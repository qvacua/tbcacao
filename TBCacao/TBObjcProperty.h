/**
 * A wrapper class for objc_property_t. It currently support only objects, i.e. int or BOOL are not (yet) supported.
 *
 * @author Tae Won Ha
 * @since 0.0.1
 */

#import <Foundation/Foundation.h>
#import <objc/objc-runtime.h>


@interface TBObjcProperty : NSObject {
@private
    NSString *name;
    NSString *nameOfClass;
}


@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *nameOfClass;


/**
 * Initializes the TBObjcProperty which wraps the objc_property of Objective-C runtime.
 *`
 * @param objc_property_t  It must not be manually free'ed since TBObjcProperty will do it.
 * @since 0.0.1
 */
- (id)initWithProperty:(objc_property_t)aProperty;


@end
