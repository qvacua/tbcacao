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


@class TBConfigManager;


@interface TBManualCacaoBuilder : NSObject {
@private
    NSMutableArray *manualCacaoProviders;

    TBConfigManager *configManager;
}

/**
 * Array of subclasses of TBManualCacaoProviders
 * @since 0.0.1
 */
@property (readonly) NSArray *manualCacaoProviders;

/**
 * TBConfigManager to read the config for the manual Cacaos. It must be set before TBManualCacaoBuilder can be used.
 * @since 0.0.1
 */
@property (retain, readwrite) TBConfigManager *configManager;


/**
 * This method reads the config and returns a dictionary with all manualCacaos with their name as their keys.
 * @since 0.0.1
 */
- (NSDictionary *)allManualCacaos;


@end
