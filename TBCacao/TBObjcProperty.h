/**
* Tae Won Ha
* http://qvacua.com
* https://github.com/qvacua
*
* See LICENSE
*/

/**
* A wrapper class for objc_property_t. It currently supports:
*  - BOOL
*  - int
*  - long long
*  - float
*  - double
*  - object
*/

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef enum {
  UnknownTBOjcProperty = '?', // unknown type
  BoolTBObjcProperty = 'c', // BOOL
  IntTBObjcProperty = 'i', // 32 bit integer
  LongTBObjcProperty = 'q', // 64 bit long, i.e. long long, not long
  FloatTBObjcProperty = 'f', // 32 bit float
  DoubleTBObjcProperty = 'd', // 64 bit double
  ObjectTBObjcProperty = '@'  // objects
} TBObjcPropertyType;

@interface TBObjcProperty : NSObject

@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *nameOfClass;

/**
* Can be nil when the property is declared as id or id <SomeProtocol>
*/
@property (readonly, nonatomic) Class clazz;
@property (readonly, nonatomic) TBObjcPropertyType type;
@property (readonly, nonatomic) BOOL readonly;

/**
* Initializes the TBObjcProperty which wraps the objc_property of Objective-C runtime. objc_property is not freed.
*/
- (id)initWithProperty:(objc_property_t)objc_property;

@end
