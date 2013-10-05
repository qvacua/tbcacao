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
    return [self initWithIdentifier:[bean classAsString] bean:bean];
}

- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    return [self initWithIdentifier:anIdentifier bean:aBean scope:TBBeanScopeSingleton];
}

- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean scope:(TBBeanScope)aScope {
    self = [super init];
    if (self) {
        _identifier = anIdentifier;
        _targetSource = aBean;
        _scope = aScope;
    }

    return self;
}

+ (id)beanContainerWithBean:(id)targetSource {
    return [[TBBeanContainer alloc] initWithBean:targetSource];
}

+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean {
    return [[TBBeanContainer alloc] initWithIdentifier:anIdentifier bean:aBean];
}

+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean scope:(TBBeanScope)aScope {
    return [[TBBeanContainer alloc] initWithIdentifier:anIdentifier bean:aBean scope:aScope];
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
    if (self.targetSource != container.targetSource && ![self.targetSource isEqual:container.targetSource])
        return NO;
    if (self.scope != container.scope)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.identifier hash];
    hash = hash * 31u + [self.targetSource hash];
    hash = hash * 31u + (NSUInteger) self.scope;
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.identifier=%@", self.identifier];
    [description appendFormat:@", self.targetSource=%@", self.targetSource];
    [description appendFormat:@", self.scope=%d", self.scope];
    [description appendString:@">"];

    return description;
}

@end
