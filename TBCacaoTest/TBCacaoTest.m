#import <Foundation/Foundation.h>
#import "TBBaseUnitTest.h"
#import "TBCacao.h"
#import "TBConfigManager.h"

#import "DummyCityManager.h"
#import "DummyFinanceManager.h"
#import "DummyInhabitantManager.h"
#import "DummyManualCacaoProvider.h"
#import "DummyPlainObject.h"
#import "DummyPlainSubObject.h"
#import "DummyStateManager.h"
#import "DummyManualCacao.h"


@interface TBCacaoTest : TBBaseUnitTest {
@private
    TBCacao *cacao;
    TBConfigManager *configManager;
}

@end


@implementation TBCacaoTest

- (void)setUp {
    cacao = [[TBCacao allocWithZone:nil] init];
    configManager = [[TBConfigManager allocWithZone:nil] initWithConfigFileName:@"cacao-dummy.plist"];
    cacao.configManager = configManager;
}

- (void)tearDown {
    [cacao release];
}

- (void)testInitializeCacao {
    [cacao initializeCacao];

    GHAssertTrue([cacao.manualCacaoProviders count] == 1, @"There is only one manual cacao provider.");

    DummyManualCacaoProvider *manualCacaoProvider = [cacao.manualCacaoProviders objectAtIndex:0];

    GHAssertNotNil(manualCacaoProvider, @"Manual cacao provider is nil.");
    GHAssertTrue([manualCacaoProvider.object class] == [DummyPlainObject class], @"Class should be DummyPlainObject.");
    GHAssertTrue([manualCacaoProvider.subObject class] == [DummyPlainSubObject class], @"Class should be DummyPlainSubObject.");

    DummyPlainObject *plainObject = [cacao cacaoForName:@"myObject"];
    DummyPlainSubObject *plainSubObject = [cacao cacaoForName:@"mySubObject"];
    DummyManualCacao *manualCacao = [cacao cacaoForName:@"myManualCacao"];

    DummyCityManager *cityManager = [cacao cacaoForName:@"myCityManager"];
    DummyFinanceManager *financeManager = [cacao cacaoForName:@"myFinanceManager"];
    DummyInhabitantManager *inhabitantManager = [cacao cacaoForName:@"myInhabitantManager"];
    DummyStateManager *stateManager = [cacao cacaoForName:@"myStateManager"];

    GHAssertNotNil(plainObject, @"plainObject should not be nil.");
    GHAssertNotNil(plainSubObject, @"plainSubObject should not be nil.");
    GHAssertNotNil(manualCacao, @"manualCacao should not be nil.");

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

    GHAssertTrue(financeManager.object == plainObject, @"Object of finance manager not correct.");
}

@end
