#import <Foundation/Foundation.h>

#import "DummyPlainObject.h"

@interface DummyFinanceManager : NSObject {
@private
    DummyPlainObject *object;
}

@property (assign, nonatomic) DummyPlainObject *object;

@end
