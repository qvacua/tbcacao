/**
 * The main class of Theobroma Cacao. Autowiring is supported only for other cacaos.
 *
 * If everything is set, you just have to call
 * [[TBCacao cacao] initializeCacao];
 * That's it!
 *
 * @author Tae Won Ha
 * @since 0.0.1
 *
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 * 
 */

#import <Foundation/Foundation.h>


@class TBConfigManager, TBManualCacaoBuilder;


@interface TBCacao : NSObject {
@private
    TBConfigManager *configManager;
    TBManualCacaoBuilder *manualCacaoBuilder;
    
    NSMutableDictionary *cacaos;
}


@property (retain, readwrite) TBConfigManager *configManager;
@property (retain, readwrite) TBManualCacaoBuilder *manualCacaoBuilder;


/**
 * Main method of TBCacao. Initializes all cacaos and manual cacaos and autowires them.
 */
- (void)initializeCacao;

/**
 * If you need a specific cacao, you can get it using this method.
 * @param name The name of the cacao as given in the config file.
 * @since 0.0.1
 */
- (id)cacaoForName:(NSString *)name;

/**
 * The single instance of TBCacao. You cannot create any other instances of it.
 * @since 0.0.1
 */
+ (TBCacao *)cacao;


@end
