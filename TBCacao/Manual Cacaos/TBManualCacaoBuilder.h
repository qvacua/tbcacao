/**
 * This is a helper class to create and load the manual Cacaos.
 *
 * @author Tae Won Ha
 * @since 0.0.1
 *
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 * 
 */

#import <Foundation/Foundation.h>


@interface TBManualCacaoBuilder : NSObject {
@private
    NSMutableArray *manualCacaoProviders;
}

@property (readonly) NSArray *manualCacaoProviders;


- (BOOL)buildManualCacaoProvidersFrom:(NSArray *)configDict;


@end
