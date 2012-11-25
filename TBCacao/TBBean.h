/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <Foundation/Foundation.h>

@interface TBBean : NSObject

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

- (BOOL)isEqual:(TBBean *)beanToCompare;
- (NSString *)description;

@end
