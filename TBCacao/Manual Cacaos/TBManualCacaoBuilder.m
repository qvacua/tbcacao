/**
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */
#import <objc/objc-runtime.h>

#import "TBManualCacaoBuilder.h"
#import "TBManualCacaoProvider.h"
#import "NSObject+TBCacao.h"
#import "TBLog.h"


@implementation TBManualCacaoBuilder


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


- (BOOL)buildManualCacaoProvidersFrom:(NSArray *)configDict {
    manualCacaoProviders = [[NSMutableArray allocWithZone:nil] initWithCapacity:[configDict count]];

    for (NSDictionary *providerDict in configDict) {

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

- (void)dealloc {
    [manualCacaoProviders release];
    
    [super dealloc];
}


@end
