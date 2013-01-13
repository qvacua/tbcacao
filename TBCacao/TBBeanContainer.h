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
* The identifier will be targetSource' class name, i.e. NSStringFromClass([targetSource class])
*/
- (id)initWithTargetSource:(id)targetSource;

/**
* The identifier will be targetSource' class name, i.e. NSStringFromClass([targetSource class])
*/
+ (id)objectWithTargetSource:(id)targetSource;
+ (id)objectWithIdentifier:(NSString *)anIdentifier bean:(id)aBean;

- (BOOL)isEqual:(TBBeanContainer *)beanToCompare;
- (NSString *)description;

@end
