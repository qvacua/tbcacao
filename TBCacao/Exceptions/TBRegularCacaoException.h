#import <Foundation/Foundation.h>
#import "TBException.h"


#define TBRegularCacaoClassNotFoundException @"TBRegularCacaoClassNotFoundException"


@interface TBRegularCacaoException : TBException {}


+ (TBRegularCacaoException *)exceptionRegularCacaoWithReason:(NSString *)reason;


@end
