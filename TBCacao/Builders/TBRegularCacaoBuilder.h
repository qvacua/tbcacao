/**
 * This is a helper class to create and load regular Cacaos.
 *
 * @author Tae Won Ha
 * @since 0.0.1
 *
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import <Foundation/Foundation.h>


@class TBConfigManager;


@interface TBRegularCacaoBuilder : NSObject {
@private
    NSMutableDictionary *regularCacaos;
    
    TBConfigManager *configManager;
}


/**
 * TBConfigManager to read the config for the regular Cacaos. It must be set before TBRegularCacaoBuilder can be used.
 * @since 0.0.1
 */
@property (retain, readwrite) TBConfigManager *configManager;

/**
 * This method reads the config and returns a dictionary with all regular Cacaos with their name as their keys.
 * @throws TBRegularCacaoException
 * @throws TBConfigException
 * @since 0.0.1
 */
- (NSDictionary *)allRegularCacaos;


@end
