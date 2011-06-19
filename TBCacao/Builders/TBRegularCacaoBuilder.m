/**
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import <objc/objc-runtime.h>

#import "TBLog.h"

#import "TBRegularCacaoBuilder.h"
#import "TBError.h"
#import "TBRegularCacaoException.h"
#import "TBConfigManager.h"
#import "TBConfigException.h"


@implementation TBRegularCacaoBuilder


@synthesize configManager;

- (id) createCacao:(NSDictionary *)config {
    NSString *name = [config objectForKey:@"name"];
    id regularCacao = [regularCacaos objectForKey:name];

    if (regularCacao) {
        return regularCacao;
    }

    NSString *className = [config objectForKey:@"class"];
    regularCacao = class_createInstance(objc_getClass([className UTF8String]), 0);

    if (regularCacao == nil) {
        return nil;
    }

    [regularCacao init];
    [regularCacaos setObject:regularCacao forKey:name];
    [regularCacao release];

    log4Info(@"Cacao \"%@\" of class \"%@\" created.", name, className);

    return regularCacao;
}

- (void) createAllCacaosWithPossibleError:(TBError **)error {
    regularCacaos = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:[self.configManager.configCacaos count]];
    
    for (NSDictionary *cacaoConfig in configManager.configCacaos) {

        if (! [self createCacao:cacaoConfig]) {

            *error = [TBError errorWithMessage:[NSString stringWithFormat:@"Cacao \"%@\" could not be created since the class \"%@\" does not seem to be present.", [cacaoConfig objectForKey:@"name"], [cacaoConfig objectForKey:@"class"]]];

            log4Fatal(@"%@", (*error).message);

        }

    }
}

- (NSDictionary *)allRegularCacaos {
    
    if (! self.configManager) {
        @throw [TBConfigException exceptionAbsentConfigManagerWithReason:@"Config manager absent."];
    }
    
    TBError *error = nil;
    [self createAllCacaosWithPossibleError:&error];

    if (error) {
        @throw [TBRegularCacaoException exceptionRegularCacaoWithReason:error.message];
    }
    
    return (NSDictionary *)regularCacaos;
    
}

- (void)dealloc {
    [configManager release];
    [regularCacaos release];
    
    [super dealloc];
}


@end
