#import <Foundation/Foundation.h>

@class DummyCityManager;

@interface DummyInhabitantManager : NSObject {
@private
    DummyCityManager *cityManager;
    NSNotificationCenter *notificationCenter;
}

@property (assign, nonatomic) DummyCityManager *cityManager;
@property (assign, nonatomic) NSNotificationCenter *notificationCenter;

@end
