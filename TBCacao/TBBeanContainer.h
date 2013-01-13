/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Foundation/Foundation.h>

@interface TBBeanContainer : NSObject

@property (readonly) NSString *identifier;
@property (readonly) id targetSource;

- (id)initWithIdentifier:(NSString *)anIdentifier bean:(id)aBean;

/**
* The identifier will be bean's class name, i.e. NSStringFromClass([targetSource class])
*/
- (id)initWithBean:(id)bean;

/**
* The identifier will be bean's class name, i.e. NSStringFromClass([targetSource class])
*/
+ (id)beanContainerWithBean:(id)targetSource;
+ (id)beanContainerWithIdentifier:(NSString *)anIdentifier bean:(id)aBean;

- (BOOL)isEqual:(TBBeanContainer *)beanContainerToCompare;
- (NSString *)description;

@end
