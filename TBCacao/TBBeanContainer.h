/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Foundation/Foundation.h>

typedef enum {
    TBBeanScopeSingleton = 0,
    TBBeanScopePrototype,
} TBBeanScope;

@interface TBBeanContainer : NSObject

@property (readonly) NSString *identifier;
@property (readonly) id targetSource;
@property (readonly) TBBeanScope scope;

/**
* Initializes the bean container with the scope TBBeanScopeSingleton
*/
- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean;

/**
* Designated initializer
*/
- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean scope:(TBBeanScope)aScope;

/**
* The identifier will be bean's class name and the scope TBBeanScopeSingleton
*/
- (id)initWithBean:(id)bean;

/**
* The identifier will be bean's class name and the scope TBBeanScopeSingleton
*/
+ (id)beanContainerWithBean:(id)targetSource;

/**
* The scope will be TBBeanScopeSingleton
*/
+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean;

/**
* Designated initializer
*/
+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean scope:(TBBeanScope)aScope;

- (BOOL)isEqual:(TBBeanContainer *)other;
- (BOOL)isEqualToContainer:(TBBeanContainer *)container;
- (NSUInteger)hash;
- (NSString *)description;

@end
