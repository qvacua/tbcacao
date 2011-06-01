#import <Foundation/Foundation.h>


@class DummyInhabitantManager, DummyFinanceManager;


@interface DummyCityManager : NSObject {
@private
    DummyInhabitantManager *inhabitantManager;
    DummyFinanceManager *financeManager;
}


@property (assign, nonatomic) DummyInhabitantManager *inhabitantManager;
@property (assign, nonatomic) DummyFinanceManager *financeManager;

@end
