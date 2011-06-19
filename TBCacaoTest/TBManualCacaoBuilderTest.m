#import "TBBaseUnitTest.h"
#import "TBManualCacaoBuilder.h"
#import "TBConfigManager.h"
#import "TBManualCacaoException.h"
#import "TBConfigException.h"

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


- (void)setUpWithConfigFileName:(NSString *)configFileName  {
    configManager = [[TBConfigManager allocWithZone:nil] initWithConfigFileName:configFileName];
    [configManager readConfig];
    
    manualCacaoBuilder = [[TBManualCacaoBuilder allocWithZone:nil] init];
    manualCacaoBuilder.configManager = configManager;
    
}

- (void)tearDown {
    [manualCacaoBuilder release];
    [configManager release];
    
    [super tearDown];
}

- (void)testAbsentConfigManager {
    [self setUpWithConfigFileName:@"cacao-dummy.plist"];
    
    manualCacaoBuilder.configManager = nil;
    
    GHAssertThrowsSpecificNamed([manualCacaoBuilder allManualCacaos], TBConfigException, TBConfigConfigManagerAbsentException, @"Config manager absent, therefore an exception should have been thrown.");
}

- (void)testWrongManualCacaoProvider {
    [self setUpWithConfigFileName:@"cacao-wrong-manual-cacao-provider.plist"];

    GHAssertThrowsSpecificNamed([manualCacaoBuilder allManualCacaos], TBManualCacaoException, TBManualCacaoProviderClassNotFoundException, @"Wrong provider, an exception should have been thrown.");
}

- (void)testWrongManualCacao {
    [self setUpWithConfigFileName:@"cacao-wrong-manual-cacao.plist"];
    
    GHAssertThrowsSpecificNamed([manualCacaoBuilder allManualCacaos], TBManualCacaoException, TBManualCacaoClassNotFoundException, @"Wrong manual cacao, an exception should have been thrown.");
}

- (void)testAllManualCacaos {
    [self setUpWithConfigFileName:@"cacao-dummy.plist"];
    
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
