#import <Foundation/Foundation.h>


@class DummyPlainObject;


@interface DummyPropertyObject : NSObject {
@private
    BOOL boolProperty;
    int intProperty;
    long long longProperty;
    float floatProperty;
    double doubleProperty;
    DummyPlainObject *objectProperty;
    
    void *voidPointerProperty;
}

@property (readonly) BOOL           boolProperty;
@property int                       intProperty;
@property long long                 longProperty;
@property float                     floatProperty;
@property (readonly) double         doubleProperty;
@property (assign) DummyPlainObject *objectProperty;

@property void                      *voidPointerProperty;

@end
