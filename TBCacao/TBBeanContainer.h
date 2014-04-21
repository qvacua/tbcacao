/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Foundation/Foundation.h>
#import "TBBean.h"

@interface TBBeanContainer : NSObject

@property (readonly) NSString *identifier;
@property (readonly) id targetSource;

/**
* Initializes the bean container with the scope TBBeanScopeSingleton
*/
- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean;

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

- (BOOL)isEqual:(TBBeanContainer *)other;
- (BOOL)isEqualToContainer:(TBBeanContainer *)container;
- (NSUInteger)hash;
- (BOOL)isEqual:(TBBeanContainer *)other;
- (BOOL)isEqualToContainer:(TBBeanContainer *)container;
- (NSUInteger)hash;
- (BOOL)isEqual:(TBBeanContainer *)other;
- (BOOL)isEqualToContainer:(TBBeanContainer *)container;
- (NSUInteger)hash;
- (NSString *)description;

@end
