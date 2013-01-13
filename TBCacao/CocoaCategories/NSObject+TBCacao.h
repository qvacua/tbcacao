/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Foundation/Foundation.h>

@interface NSObject (TBCacao)

/**
 * Returns the class name as string.
 */
+ (NSString *)classAsString;

/**
 * Returns an array of all Objective-C properties as TBObjcProperty including properties of all superclasses.
 * The properties of NSObject is not included.
 */
+ (NSArray *)objcProperties;

/**
 * Returns an array of all Objective-C properties as TBObjcProperty not including properties of its superclass(es).
 */
+ (NSArray *)objcPropertiesWithoutSuperclass;

@end
