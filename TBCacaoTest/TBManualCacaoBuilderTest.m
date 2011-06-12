#import "TBBaseUnitTest.h"
#import "TBManualCacaoBuilder.h"
#import "TBConfigManager.h"

#import "DummyManualCacaoProvider.h"
#import "DummyManualCacaoProviderSecond.h"
#import "DummyPlainObject.h"
#import "DummyPlainSubObject.h"


@interface TBManualCacaoBuilderTest : TBBaseUnitTest {
@private
    TBManualCacaoBuilder *manualCacaoBuilder;
    TBConfigManager *configManager;
}

@end

@implementation TBManualCacaoBuilderTest


- (void)setUp {
    [super setUp];
    
    configManager = [[TBConfigManager allocWithZone:nil] initWithConfigFileName:@"cacao-dummy.plist"];
    [configManager readConfigWithPossibleError:nil];
    
    manualCacaoBuilder = [[TBManualCacaoBuilder allocWithZone:nil] init];
    manualCacaoBuilder.configManager = configManager;
}

- (void)tearDown {
    [manualCacaoBuilder release];
    [configManager release];
    
    [super tearDown];
}

- (void)testAllManualCacaos {
    NSDictionary *manualCacaoDictionary = [manualCacaoBuilder allManualCacaos];
    
    GHAssertTrue([manualCacaoBuilder.manualCacaoProviders count] == 2, @"There should be two manual cacao providers.");
    
    DummyManualCacaoProvider *manualCacaoProvider = nil;
    DummyManualCacaoProviderSecond *manualCacaoProviderSecond = nil;
    for (id provider in manualCacaoBuilder.manualCacaoProviders) {
        if ([provider isMemberOfClass:[DummyManualCacaoProvider class]]) {
            manualCacaoProvider = provider;
        }
        if ([provider isMemberOfClass:[DummyManualCacaoProviderSecond class]]) {
            manualCacaoProviderSecond = provider;
        }
    }
    
    GHAssertNotNil(manualCacaoProvider, @"Manual cacao provider is nil.");
    GHAssertTrue([manualCacaoProvider.object class] == [DummyPlainObject class], @"Class should be DummyPlainObject.");
    GHAssertTrue([manualCacaoProvider.subObject class] == [DummyPlainSubObject class], @"Class should be DummyPlainSubObject.");
    
    GHAssertNotNil(manualCacaoProviderSecond, @"Manual cacao provider second is nil.");
    GHAssertTrue([manualCacaoProviderSecond.notificationCenter class] == [NSNotificationCenter class], @"Class should be NSNotificationCenter");
    
    DummyPlainObject *plainObject = [manualCacaoDictionary objectForKey:@"myObject"];
    DummyPlainSubObject *plainSubObject = [manualCacaoDictionary objectForKey:@"mySubObject"];
    DummyManualCacao *manualCacao = [manualCacaoDictionary objectForKey:@"myManualCacao"];
    NSNotificationCenter *notificationCenter = [manualCacaoDictionary objectForKey:@"myNotificationCenter"];
    
    GHAssertNotNil(plainObject, @"plainObject should not be nil.");
    GHAssertNotNil(plainSubObject, @"plainSubObject should not be nil.");
    GHAssertNotNil(manualCacao, @"manualCacao should not be nil.");
    GHAssertTrue(notificationCenter == [NSNotificationCenter defaultCenter], @"notificationCenter is not the default center.");
}


@end
