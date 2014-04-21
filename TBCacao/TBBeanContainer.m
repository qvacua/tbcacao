/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "TBBeanContainer.h"
#import "NSObject+TBCacao.h"


@implementation TBBeanContainer

#pragma mark Public
- (id)initWithBean:(id)bean {
    return [self initWithIdentifier:[[bean class] classAsString] bean:bean];
}

- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    self = [super init];
    if (self) {
        _identifier = anIdentifier;
        _targetSource = aBean;
    }

    return self;
}

+ (id)beanContainerWithBean:(id)targetSource {
    return [[TBBeanContainer alloc] initWithBean:targetSource];
}

+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    return [[TBBeanContainer alloc] initWithIdentifier:anIdentifier bean:aBean];
}

#pragma mark NSObject
- (BOOL)isEqual:(TBBeanContainer *)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToContainer:other];
}

- (BOOL)isEqualToContainer:(TBBeanContainer *)container {
    if (self == container)
        return YES;
    if (container == nil)
        return NO;
    if (self.identifier != container.identifier && ![self.identifier isEqualToString:container.identifier])
        return NO;
    return YES;
}

- (NSUInteger)hash {
  NSUInteger hash = [self.identifier hash];
  hash = hash * 31u + [self.targetSource hash];
  return hash;
}

- (NSString *)description {
  NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
  [description appendFormat:@"self.identifier=%@", self.identifier];
  [description appendFormat:@", self.targetSource=%@", self.targetSource];
  [description appendString:@">"];
  return description;
}

@end
