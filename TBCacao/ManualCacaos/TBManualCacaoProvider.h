/**
 * Abstract class which can be subclassed to provide manual Cacaos like NSNotificationCenter or NSManagedObjectContext.
 * DO NOT instanticate this class since it's a noop class.
 *
 * Every subclass of TBManualCacaoProvider present in the manual-cacao-provider array in the config file will be scanned to create manual cacaos.
 *
 * @author Tae Won Ha
 * @since 0.0.1
 *
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 * 
 */

#import <Foundation/Foundation.h>


@interface TBManualCacaoProvider : NSObject {} @end
