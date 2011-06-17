#import <Foundation/Foundation.h>
#import "TBBaseUnitTest.h"
#import "TBCacao.h"
#import "TBConfigManager.h"
#import "TBManualCacaoBuilder.h"

#import "DummyCityManager.h"
#import "DummyFinanceManager.h"
#import "DummyInhabitantManager.h"
#import "DummyManualCacaoProvider.h"
#import "DummyManualCacaoProviderSecond.h"
#import "DummyPlainObject.h"
#import "DummyStateManager.h"
#import "DummyManualCacao.h"


@interface TBCacaoTest : TBBaseUnitTest {
@private
    TBCacao *cacao;
    TBConfigManager *configManager;
    TBManualCacaoBuilder *manualCacaoBuilder;
}

@end


@implementation TBCacaoTest

- (void)setUp {
    [super setUp];
    
    cacao = [[TBCacao allocWithZone:nil] init];
    
    configManager = [[TBConfigManager allocWithZone:nil] initWithConfigFileName:@"cacao-dummy.plist"];
    cacao.configManager = configManager;
}

- (void)tearDown {
    [configManager release];
    [manualCacaoBuilder release];
    
    [cacao release];
    
    [super tearDown];
}

- (void)testInitializeCacao {
    [cacao initializeCacao];

    // manual Cacaos
    DummyPlainObject *plainObject = [cacao cacaoForName:@"myObject"];
    DummyManualCacao *manualCacao = [cacao cacaoForName:@"myManualCacao"];
    NSNotificationCenter *notificationCenter = [cacao cacaoForName:@"myNotificationCenter"];

    // cacaos
    DummyCityManager *cityManager = [cacao cacaoForName:@"myCityManager"];
    DummyFinanceManager *financeManager = [cacao cacaoForName:@"myFinanceManager"];
    DummyInhabitantManager *inhabitantManager = [cacao cacaoForName:@"myInhabitantManager"];
    DummyStateManager *stateManager = [cacao cacaoForName:@"myStateManager"];

    GHAssertNotNil(cityManager, @"cityManager should not be nil.");
    GHAssertNotNil(financeManager, @"financeManager should not be nil.");
    GHAssertNotNil(inhabitantManager, @"inhabitantManager should not be nil.");
    GHAssertNotNil(stateManager, @"stateManager should not be nil.");

    GHAssertTrue(manualCacao.stateManager == stateManager, @"State manager of manual cacao not correct.");

    GHAssertTrue(stateManager.cityManager == cityManager, @"City manager of state manager not correct.");
    GHAssertTrue(stateManager.financeManager == financeManager, @"Finance manager of state manager not correct.");

    GHAssertTrue(cityManager.inhabitantManager == inhabitantManager, @"Inhabitant manager of city manager not correct.");
    GHAssertTrue(cityManager.financeManager == financeManager, @"Finance manager of city manager not correct.");

    GHAssertTrue(inhabitantManager.cityManager == cityManager, @"City manager of inhabitant manager not correct.");
    GHAssertTrue(inhabitantManager.notificationCenter == notificationCenter, @"Notification center of inhabitant manager not correct.");

    GHAssertTrue(financeManager.object == plainObject, @"Object of finance manager not correct.");
}

@end
