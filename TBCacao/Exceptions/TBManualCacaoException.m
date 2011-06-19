/**
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import "TBManualCacaoException.h"


@implementation TBManualCacaoException


+ (TBManualCacaoException *)exceptionProviderWithReason:(NSString *)reason {
    return [[[TBManualCacaoException allocWithZone:nil] initWithName:TBManualCacaoProviderClassNotFoundException 
                                                              reason:reason
                                                            userInfo:nil] autorelease];
}

+ (TBManualCacaoException *)exceptionManualCacaoWithReason:(NSString *)reason {
    return [[[TBManualCacaoException allocWithZone:nil] initWithName:TBManualCacaoClassNotFoundException
                                                              reason:reason
                                                            userInfo:nil] autorelease];
}


@end
