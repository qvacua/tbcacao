/*
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import <objc/objc-runtime.h>

#import "TBLog.h"

#import "NSObject+TBCacao.h"
#import "NSString+TBCacao.h"

#import "TBCacao.h"
#import "TBObjcProperty.h"
#import "TBManualCacaoProvider.h"
#import "TBConfigManager.h"
#import "TBManualCacaoBuilder.h"
#import "TBError.h"


static TBCacao *cacao = nil;


@implementation TBCacao


@synthesize configManager;
@synthesize manualCacaoBuilder;


- (NSArray *)objcPropertiesForClass:(Class)class {
    unsigned int nrOfProps;
    objc_property_t *properties = class_copyPropertyList(class, &nrOfProps);

    NSMutableArray *result = [NSMutableArray arrayWithCapacity:nrOfProps];
    for (int i = 0; i < nrOfProps; i++) {
        TBObjcProperty *property = [[TBObjcProperty allocWithZone:nil] initWithProperty:properties[i]];
        [result addObject:property];
        [property release];
    }

    free(properties);

    if ([configManager hasClass:class_getSuperclass(class)]) {
        [result addObjectsFromArray:[self objcPropertiesForClass:class_getSuperclass(class)]];
    }

    return (NSArray *)result;
}

- (NSArray *)objcPropertiesForCacao:(NSString *)name {
    Class class = objc_getClass([[configManager.configCacaos valueForKeyPath:[name stringByAppendingFormat:@".%@", @"class"]] UTF8String]);

    return [self objcPropertiesForClass:class];
}

- (void) setForCacao: (id) cacao autowireCacao: (id) cacaoToAutowire  {
    NSArray *objcProperties = [self objcPropertiesForClass:[cacao class]];

    for (TBObjcProperty *property in objcProperties) {
        if ([[[cacaoToAutowire class] classAsString] isEqualToString:property.nameOfClass]) {
            [cacao setValue:cacaoToAutowire forKey:property.name];
        }
    }
}

- (void) autowireCacao:(id)cacao cacaosToAutowire:(NSArray *)cacaosToAutowire  {
    for (NSString *autowireCacaoName in cacaosToAutowire) {
        id cacaoToAutowire = [self cacaoForName:autowireCacaoName];

        [self setForCacao: cacao autowireCacao: cacaoToAutowire];
    }
}

- (id) createCacao:(NSDictionary *)config {
    NSString *name = [config objectForKey:@"name"];
    id cacao = [cacaos objectForKey:name];

    if (cacao) {
        return cacao;
    }

    NSString *className = [config objectForKey:@"class"];
    cacao = class_createInstance(objc_getClass([className UTF8String]), 0);

    if (cacao == nil) {
        log4Warn(@"Cacao \"%@\" could not be created since the class \"%@\" does not seem to be present.", name, className);

        return nil;
    }

    [cacao init];
    [cacaos setObject:cacao forKey:name];
    [cacao release];

    log4Info(@"Cacao \"%@\" of class \"%@\" created.", name, className);

    return cacao;
}

- (void) autowireAllCacaos {
    for (NSDictionary *cacaoConfig in configManager.configManualCacaos) {
        NSString *name = [cacaoConfig objectForKey:@"name"];

        [self autowireCacao:[self cacaoForName:name] cacaosToAutowire:[cacaoConfig objectForKey:@"autowire"]];

        log4Info(@"Manual Cacao \"%@\" autowired.", name);
    }

    for (NSDictionary *cacaoConfig in configManager.configCacaos) {
        NSString *name = [cacaoConfig objectForKey:@"name"];
        id cacao = [self cacaoForName:name];

        if (cacao) {
            [self autowireCacao:[self cacaoForName:name] cacaosToAutowire:[cacaoConfig objectForKey:@"autowire"]];
            log4Info(@"Cacao \"%@\" autowired.", name);
        } else {
            log4Info(@"Cacao \"%@\" is not there and therefore cannot be autowired.", name);
        }
    }
}

- (void) createAllCacaos {
    for (NSDictionary *cacaoConfig in configManager.configCacaos) {
        [self createCacao:cacaoConfig];
    }
}


- (void)initializeCacao {
    log4Info(@"Cacao initialization started.");

    if (! configManager) {
        log4Fatal(@"No config manager present.");

        return;
    }

    if (! manualCacaoBuilder) {
        log4Fatal(@"No manual cacao builder present.");

        return;
    }

    [configManager readConfigWithPossibleError:nil];

    cacaos = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:([configManager.configCacaos count] + [configManager.configManualCacaos count])];

    [cacaos addEntriesFromDictionary:[manualCacaoBuilder allManualCacaos]];

    [self createAllCacaos];

    [self autowireAllCacaos];

    log4Info(@"Cacao initialization finished.");
}

- (id)cacaoForName:(NSString *)name {
    return [cacaos objectForKey:name];
}


+ (TBCacao *)cacao {
    @synchronized(self) {
        if (cacao == nil) {
            cacao = [[self allocWithZone:nil] init];
        }

        return cacao;
    }

    return nil;
}

- (void)dealloc {
    [configManager release];
    [manualCacaoBuilder release];

    [cacaos release];

    [super dealloc];
}


@end
