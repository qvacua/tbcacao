#import <Foundation/Foundation.h>


@class DummyStateManager;

@interface DummyManualCacao : NSObject {
@private
    DummyStateManager *stateManager;
}

@property (assign, nonatomic) DummyStateManager *stateManager;

@end
