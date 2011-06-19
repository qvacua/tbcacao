#import "TBBaseUnitTest.h"
#import "TBRegularCacaoBuilder.h"
#import "TBConfigManager.h"
#import "TBRegularCacaoException.h"
#import "TBConfigException.h"


@interface TBregularCacaoBuilderTest : TBBaseUnitTest {
@private
    TBRegularCacaoBuilder *regularCacaoBuilder;
    TBConfigManager *configManager;
}

@end

@implementation TBregularCacaoBuilderTest


- (void)setUpWithConfigFileName:(NSString *)configFileName  {
    configManager = [[TBConfigManager allocWithZone:nil] initWithConfigFileName:configFileName];
    [configManager readConfig];
    
    regularCacaoBuilder = [[TBRegularCacaoBuilder allocWithZone:nil] init];
    regularCacaoBuilder.configManager = configManager;
}

- (void)tearDown {
    [regularCacaoBuilder release];
    [configManager release];
    
    [super tearDown];
}

- (void)testAbsentConfigManager {
    [self setUpWithConfigFileName:@"cacao-dummy.plist"];
    
    regularCacaoBuilder.configManager = nil;
    
    GHAssertThrowsSpecificNamed([regularCacaoBuilder allRegularCacaos], TBConfigException, TBConfigConfigManagerAbsentException, @"Config manager absent, therefore an exception should have been thrown.");
}

- (void)testWrongRegularCacao {
    [self setUpWithConfigFileName:@"cacao-wrong-regular-cacao.plist"];

    GHAssertThrowsSpecificNamed([regularCacaoBuilder allRegularCacaos], TBRegularCacaoException, TBRegularCacaoClassNotFoundException, @"Wrong provider, an exception should have been thrown.");
}

- (void)testAllRegularCacaos {
    [self setUpWithConfigFileName:@"cacao-dummy.plist"];
    
    NSDictionary *regularCacaoDictionary = [regularCacaoBuilder allRegularCacaos];
    
    GHAssertTrue([regularCacaoDictionary count] == 4, @"There should be four regular Cacaos.");
    
    GHAssertNotNil([regularCacaoDictionary objectForKey:@"myFinanceManager"], @"Finance manager should not be nil.");
    GHAssertNotNil([regularCacaoDictionary objectForKey:@"myInhabitantManager"], @"Inhabitant manager should not be nil.");
    GHAssertNotNil([regularCacaoDictionary objectForKey:@"myCityManager"], @"City manager should not be nil.");
    GHAssertNotNil([regularCacaoDictionary objectForKey:@"myStateManager"], @"State manager should not be nil.");
}


@end

