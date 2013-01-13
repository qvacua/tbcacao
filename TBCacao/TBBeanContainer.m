/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "TBBeanContainer.h"

@implementation TBBeanContainer {
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

- (id)initWithBean:(id)bean {
    return [self initWithIdentifier:NSStringFromClass([bean class]) bean:bean];
}

+ (id)beanContainerWithBean:(id)targetSource {
    return [[TBBeanContainer alloc] initWithBean:targetSource];
}

+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    return [[TBBeanContainer alloc] initWithIdentifier:anIdentifier bean:aBean];
}

- (BOOL)isEqual:(TBBeanContainer *)beanContainerToCompare {
    return [self.identifier isEqualToString:beanContainerToCompare.identifier];
}

- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"Bean %@ of class %@", self.identifier, NSStringFromClass([self.targetSource class])];
}

@end
