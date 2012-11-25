/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <Foundation/Foundation.h>

@interface NSObject (TBCacao)

/**
 * Class method which returns the class name as string.
 * @since 0.0.1
 */
+ (NSString *)classAsString;

/**
 * Class method which returns an array of all Objective-C properties as TBObjcProperty including properties of all superclasses.
 * The properties of NSObject is NOT included.
 * @since 0.0.1
 */
+ (NSArray *)objcProperties;

/**
 * Class method which returns an array of all Objective-C properties as TBObjcProperty NOT including properties of its superclass(es).
 * @since 0.0.1
 */
+ (NSArray *)objcPropertiesWithoutSuperclass;

@end
