#import "TBError.h"


@implementation TBError


@dynamic message;


- (NSString *)message {
    return [[self userInfo] objectForKey:TBErrorKeyMessage];
}

+ (id)errorWithMessage:(NSString *)message {
    return [TBError errorWithDomain:TBErrorDomain
                               code:TBErrorCodeDefault 
                           userInfo:[NSDictionary dictionaryWithObject:message forKey:TBErrorKeyMessage]];
}


@end
