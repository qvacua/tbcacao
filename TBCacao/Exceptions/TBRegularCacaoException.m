#import "TBRegularCacaoException.h"


@implementation TBRegularCacaoException


+ (TBRegularCacaoException *)exceptionRegularCacaoWithReason:(NSString *)reason {
    return [[[TBRegularCacaoException allocWithZone:nil] initWithName:TBRegularCacaoClassNotFoundException
                                                               reason:reason
                                                             userInfo:nil] autorelease];
}


@end
