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
#import "TBConfigManager.h"
#import "TBManualCacaoBuilder.h"
#import "TBRegularCacaoBuilder.h"

#import "TBException.h"
#import "TBConfigException.h"


static TBCacao *cacao = nil;


@implementation TBCacao


@synthesize configManager;


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

- (void)setForCacao:(id)cacao autowireCacao:(id)cacaoToAutowire  {
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

- (void)autowireAllCacaos {
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

- (void)readConfig {
    if (! configManager) {
        TBConfigException *exception = [TBConfigException exceptionAbsentConfigManagerWithReason:@"No config manager present."];
        
        log4Fatal(@"%@", [exception reason]);
        
        @throw exception;
    }
    
    [configManager readConfig]; // @throws TBConfigException
}

- (void)buildManualCacaos {
    TBManualCacaoBuilder *manualCacaoBuilder = [[TBManualCacaoBuilder allocWithZone:nil] init];
    manualCacaoBuilder.configManager = configManager;
    NSDictionary *allManualCacaos;
    
    @try {
        allManualCacaos = [manualCacaoBuilder allManualCacaos]; // @throws TBManualCacaoException or TBConfigException
    } @catch (TBException *exception) {
        @throw exception;
    } @finally {
        [cacaos addEntriesFromDictionary:allManualCacaos];
        [manualCacaoBuilder release];
    }
}

- (void)buildRegularCacaos {
    TBRegularCacaoBuilder *regularCacaoBuilder = [[TBRegularCacaoBuilder allocWithZone:nil] init];
    regularCacaoBuilder.configManager = configManager;
    NSDictionary *allRegularCacaos;
    
    @try {
        allRegularCacaos = [regularCacaoBuilder allRegularCacaos]; // @throws TBRegularCacaoException or TBConfigException
    } @catch (TBException *exception) {
        @throw exception;
    } @finally {
        [cacaos addEntriesFromDictionary:allRegularCacaos];
        [regularCacaoBuilder release];
    }
}

- (void)initializeCacao {
    log4Info(@"Cacao initialization started.");

    [self readConfig]; // @throws TBConfigException
    
    cacaos = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:([configManager.configCacaos count] + [configManager.configManualCacaos count])];

    [self buildManualCacaos]; // @throws TBManualCacaoException or TBConfigException

    [self buildRegularCacaos]; // @throws TBRegularCacaoException or TBConfigException

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

    [cacaos release];

    [super dealloc];
}


@end
