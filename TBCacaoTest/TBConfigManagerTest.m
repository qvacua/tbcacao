#import <Foundation/Foundation.h>

#import "TBBaseUnitTest.h"
#import "TBConfigManager.h"
#import "TBConfigException.h"
#import "DummyPlainObject.h"
#import "DummyCityManager.h"
#import "DummyFinanceManager.h"


@interface TBConfigManagerTest : TBBaseUnitTest {
@private
    TBConfigManager *configManager;
}

@end


@implementation TBConfigManagerTest


- (void)setUp {
    configManager = [[TBConfigManager allocWithZone:nil] init];
}

- (void)tearDown {
    [configManager release];
}


- (void)testInit {
    GHAssertTrue([configManager.configFileName isEqualToString:TBCacaoConfigFileNameDefault], @"The default file name should be set in the init method.");
}

- (void)testInitWithConfigFileName {
    [configManager release];
    configManager = [[TBConfigManager allocWithZone:nil] initWithConfigFileName:@"some name"];

    GHAssertTrue([configManager.configFileName isEqualToString:@"some name"], @"The config file name is not the given one.");
}

- (void)testNoConfigFileName {
    configManager.configFileName = nil;
    
    GHAssertThrowsSpecificNamed([configManager readConfig], TBConfigException, TBConfigBuildNumberIncompatibleException, @"No config file name and therefore a TBConfigException should have been thrown.");
}

- (void)testWrongVersion {
    configManager.configFileName = @"cacao-wrong-version.plist";
            
    GHAssertThrowsSpecificNamed([configManager readConfig], TBConfigException, TBConfigBuildNumberIncompatibleException, @"The version should not be correct and therefore a TBConfigException should have been thrown.");
}

- (void)testWrongConfigFile {
    configManager.configFileName = @"cacao-plainly-wrong.plist";
    
    GHAssertThrowsSpecificNamed([configManager readConfig], TBConfigException, TBConfigConfigFileBadlyFormattedException, @"The config file is badly formatted. An exception should have been thrown.");
}

- (void)testReadConfig {
    configManager.configFileName = @"cacao-dummy.plist";
    
    GHAssertNoThrow([configManager readConfig], @"No exception should be thrown.");
    
    GHAssertTrue([configManager.configCacaos count] == 4, @"The number of cacaos is 4.");
    GHAssertTrue([configManager.configManualCacaos count] == 4, @"The number of manual cacaos is 4.");
    GHAssertTrue([configManager.configManualCacaoProviders count] == 2, @"The number of manual cacao provider is 2.");
}

- (void)testHasClass {
    configManager.configFileName = @"cacao-dummy.plist";
    
    [configManager readConfig];
    
    GHAssertTrue([configManager hasClass:[DummyCityManager class]], @"%@ is included.", [DummyCityManager class]);
    GHAssertTrue([configManager hasClass:[DummyFinanceManager class]], @"%@ is included.", [DummyFinanceManager class]);
    GHAssertTrue([configManager hasClass:[DummyPlainObject class]], @"%@ is included as manual cacao.", [DummyPlainObject class]);
    GHAssertTrue([configManager hasClass:[NSNotificationCenter class]], @"%@ is included as manual cacao.", [NSNotificationCenter class]);
    GHAssertFalse([configManager hasClass:[NSPredicate class]], @"%@ is not included.", [NSPredicate class]);
}

@end
