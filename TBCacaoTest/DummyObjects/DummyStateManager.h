#import <Foundation/Foundation.h>


@class DummyCityManager, DummyFinanceManager;


@interface DummyStateManager : NSObject {
@private
    DummyCityManager *cityManager;
    DummyFinanceManager *financeManager;
}

@property (assign, nonatomic) DummyCityManager *cityManager;
@property (assign, nonatomic) DummyFinanceManager *financeManager;

@end
