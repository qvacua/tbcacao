/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <Foundation/Foundation.h>

@class DummyPlainObject;

@interface DummyPropertyObject : NSObject {
@private
    BOOL boolProperty;
    int intProperty;
    long long longProperty;
    float floatProperty;
    double doubleProperty;
    __weak DummyPlainObject *objectProperty;
    
    void *voidPointerProperty;
    id <NSLocking> _protocolProperty;
    id _idProperty;
}

@property (readonly) BOOL boolProperty;
@property int intProperty;
@property long long longProperty;
@property float floatProperty;
@property (readonly) double doubleProperty;
@property (weak) DummyPlainObject *objectProperty;
@property void *voidPointerProperty;
@property id <NSLocking> protocolProperty;
@property id idProperty;

@end
