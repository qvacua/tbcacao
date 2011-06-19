#import <Foundation/Foundation.h>
#import "DummyPlainObject.h"


@interface DummyPlainSubObject : DummyPlainObject {
@private
    NSArray *arrayProperty;
}

@property (retain) NSArray *arrayProperty;

@end
