/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBBean.h"

@implementation TBBean {
@private
    NSString *_identifier;
    id _targetSource;
}

@synthesize identifier = _identifier;
@synthesize targetSource = _targetSource;

#pragma mark NSObject
- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    self = [super init];
    if (self) {
        _identifier = anIdentifier;
        _targetSource = aBean;
    }

    return self;
}

+ (id)objectWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    return [[TBBean alloc] initWithIdentifier:anIdentifier bean:aBean];
}

- (BOOL)isEqual:(TBBean *)beanToCompare {
    return [self.identifier isEqualToString:beanToCompare.identifier];
}

@end
