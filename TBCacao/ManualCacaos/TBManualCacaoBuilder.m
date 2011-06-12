/**
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */
#import <objc/objc-runtime.h>

#import "TBManualCacaoBuilder.h"
#import "TBManualCacaoProvider.h"
#import "TBConfigManager.h"
#import "TBObjcProperty.h"
#import "NSObject+TBCacao.h"
#import "TBLog.h"


@implementation TBManualCacaoBuilder


@dynamic manualCacaoProviders;
@synthesize configManager;


- (NSArray *)manualCacaoProviders {
    return (NSArray *)manualCacaoProviders;
}


- (BOOL)checkSuperclassOfManualCacaoProvider:(Class)class {

    if (class == nil) {
        NSString *errorMsg = [NSString stringWithFormat:@"The class %@ seems to be not there in the ObjC-Runtime, therefore it could not be instantiated.", class];

        log4Fatal(@"%@", errorMsg);

        return NO;
    }

    if ([class superclass] != [TBManualCacaoProvider class]) {
        NSString *errorMsg = [NSString stringWithFormat:@"The manual Cacao provider \"%@\" is not a subclass of \"%@.\"", [class classAsString], [TBManualCacaoProvider classAsString]];

        log4Fatal(@"%@", errorMsg);

        return NO;
    }

    return YES;
}


- (BOOL)buildManualCacaoProviders {
    manualCacaoProviders = [[NSMutableArray allocWithZone:nil] initWithCapacity:[configManager.configManualCacaoProviders count]];

    for (NSDictionary *providerDict in configManager.configManualCacaoProviders) {

        NSString *className = [providerDict objectForKey:@"class"];

        id class = objc_getClass([className UTF8String]);

        if ([self checkSuperclassOfManualCacaoProvider:class] == NO) {
            break;
        }

        id provider = [class_createInstance(class, 0) init];
        [manualCacaoProviders addObject:provider];
        [provider release];

    }

    return YES;
}

- (NSString *)classNameOfManualCacao:(NSString *) name  {
    for (NSDictionary *manualCacaoConfig in configManager.configManualCacaos) {
        if ([[manualCacaoConfig objectForKey:@"name"] isEqualToString:name]) {
            return [manualCacaoConfig objectForKey:@"class"];
        }
    }

    return nil;
}

- (id)manualCacaoProviderFromFirstHavingPropertyClass:(NSString *)className {

    for (id provider in self.manualCacaoProviders) {
        NSArray *properties = [[provider class] objcProperties];

        for (TBObjcProperty *property in properties) {

            if ([property.nameOfClass isEqualToString:className]) {
                return [provider valueForKey:property.name];
            }

        }

    }

    log4Fatal(@"There is no manual Cacao provider which has a property with the class \"%@.\"", className);

    return nil;
}

- (id)createManualCacao:(NSString *)name {
    id manualCacao = [self manualCacaoProviderFromFirstHavingPropertyClass:[self classNameOfManualCacao:name]];

    log4Info(@"Manual Cacao \"%@\" created.", name);

    return manualCacao;
}

- (NSDictionary *)allManualCacaos {
    NSMutableDictionary *manualCacaos = [NSMutableDictionary dictionaryWithCapacity:[configManager.configManualCacaos count]];

    if (! [self buildManualCacaoProviders]) {
        return nil;
    }

    for (NSDictionary *cacaoConfig in configManager.configManualCacaos) {
        NSString *name = [cacaoConfig objectForKey:@"name"];

        id manualCacao = [self createManualCacao:name];

        [manualCacaos setObject:manualCacao forKey:name];
    }

    return manualCacaos;
}

- (void)dealloc {
    [manualCacaoProviders release];

    [super dealloc];
}


@end
