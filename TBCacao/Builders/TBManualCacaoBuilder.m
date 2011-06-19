/**
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import <objc/objc-runtime.h>

#import "TBManualCacaoBuilder.h"
#import "TBConfigManager.h"
#import "TBObjcProperty.h"
#import "NSObject+TBCacao.h"
#import "TBLog.h"
#import "TBError.h"
#import "TBManualCacaoException.h"
#import "TBConfigException.h"


@implementation TBManualCacaoBuilder


@dynamic manualCacaoProviders;
@synthesize configManager;


- (NSArray *)manualCacaoProviders {
    return (NSArray *)manualCacaoProviders;
}


- (BOOL)buildManualCacaoProvidersWithPossibleError:(TBError **)error {
    manualCacaoProviders = [[NSMutableArray allocWithZone:nil] initWithCapacity:[configManager.configManualCacaoProviders count]];

    for (NSDictionary *providerDict in configManager.configManualCacaoProviders) {

        NSString *className = [providerDict objectForKey:@"class"];

        id class = objc_getClass([className UTF8String]);

        if (! class) {
            *error = [TBError errorWithMessage:[NSString stringWithFormat:@"The class %@ seems to be not there in the ObjC-Runtime, therefore it could not be instantiated.", class]];

            log4Fatal(@"%@", (*error).message);

            return NO;
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

- (id)manualCacaoFromFirstProviderHavingPropertyClass:(NSString *)className {

    for (id provider in self.manualCacaoProviders) {
        NSArray *properties = [[provider class] objcProperties];

        for (TBObjcProperty *property in properties) {

            if ([property.nameOfClass isEqualToString:className]) {
                return [provider valueForKey:property.name];
            }

        }

    }

    return nil;
}

- (id)createManualCacao:(NSString *)name error:(TBError **)error {
    NSString *className = [self classNameOfManualCacao:name];

    id manualCacao = [self manualCacaoFromFirstProviderHavingPropertyClass:className];

    if (! manualCacao) {
        *error = [TBError errorWithMessage:[NSString stringWithFormat:@"There is no manual Cacao provider which has a property with the class \"%@.\"", className]];

        log4Fatal(@"%@", (*error).message);

        return nil;
    }

    log4Info(@"Manual Cacao \"%@\" created.", name);

    return manualCacao;
}

- (NSDictionary *)allManualCacaos {
    
    if (! self.configManager) {
        @throw [TBConfigException exceptionAbsentConfigManagerWithReason:@"Config manager not found."];
    }
    
    NSMutableDictionary *manualCacaos = [NSMutableDictionary dictionaryWithCapacity:[configManager.configManualCacaos count]];

    TBError *error = nil;

    if (! [self buildManualCacaoProvidersWithPossibleError:&error]) {
        @throw [TBManualCacaoException exceptionProviderWithReason:error.message];
    }

    for (NSDictionary *cacaoConfig in configManager.configManualCacaos) {
        NSString *name = [cacaoConfig objectForKey:@"name"];

        id manualCacao = [self createManualCacao:name error:&error];

        if (error || ! manualCacao) {
            @throw [TBManualCacaoException exceptionManualCacaoWithReason:error.message];
        }

        [manualCacaos setObject:manualCacao forKey:name];
    }

    return manualCacaos;
    
}

- (void)dealloc {
    [manualCacaoProviders release];

    [super dealloc];
}


@end
