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
    id _bean;
}

@synthesize identifier = _identifier;
@synthesize bean = _bean;

- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    self = [super init];
    if (self) {
        _identifier = anIdentifier;
        _bean = aBean;
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
