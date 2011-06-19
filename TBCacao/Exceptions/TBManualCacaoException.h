/**
 * Exception thrown when manual Cacao related stuff goes wrong.
 *
 * @author Tae Won Ha
 * @since 0.0.1
 *
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import <Foundation/Foundation.h>
#import "TBException.h"


#define TBManualCacaoProviderClassNotFoundException @"TBManualCacaoProviderClassNotFoundException"
#define TBManualCacaoClassNotFoundException         @"TBManualCacaoClassNotFoundException"


@interface TBManualCacaoException : TBException {}

/**
 * Class method which returns a TBManualCacaoException object when a TBManualCacaoProvider cannot be created with a given reason. The userinfo dictionary will be nil.
 * @since 0.0.1
 */
+ (TBManualCacaoException *)exceptionProviderWithReason:(NSString *)reason;

/**
 * Class method which returns a TBManualCacaoException object when a manual Cacao cannot be created with a given reason. The userinfo dictionary will be nil.
 * @since 0.0.1
 */
+ (TBManualCacaoException *)exceptionManualCacaoWithReason:(NSString *)reason;

@end
