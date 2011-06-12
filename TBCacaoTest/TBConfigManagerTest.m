#import <Foundation/Foundation.h>

#import "TBBaseUnitTest.h"
#import "TBConfigManager.h"
#import "TBError.h"
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


- (void)testWrongVersion {
    configManager.configFileName = @"cacao-wrong-version.plist";
    
    TBError *error = nil;

    GHAssertFalse([configManager readConfigWithPossibleError:&error], @"The version should not be correct.");

    GHAssertNotNil(error, @"The error object should not be nil.");
    GHAssertTrue([error.message length] > 0, @"The error message should not be empty.");
}

- (void)testReadConfig {
    configManager.configFileName = @"cacao-dummy.plist";
    
    GHAssertTrue([configManager readConfigWithPossibleError:nil], @"No error should occur.");
    GHAssertTrue([configManager.configCacaos count] == 4, @"The number of cacaos is 4.");
    GHAssertTrue([configManager.configManualCacaos count] == 4, @"The number of manual cacaos is 4.");
    GHAssertTrue([configManager.configManualCacaoProviders count] == 2, @"The number of manual cacao provider is 2.");
}

- (void)testHasClass {
    configManager.configFileName = @"cacao-dummy.plist";
    
    [configManager readConfigWithPossibleError:nil];
    
    GHAssertTrue([configManager hasClass:[DummyCityManager class]], @"%@ is included.", [DummyCityManager class]);
    GHAssertTrue([configManager hasClass:[DummyFinanceManager class]], @"%@ is included.", [DummyFinanceManager class]);
    GHAssertTrue([configManager hasClass:[DummyPlainObject class]], @"%@ is included as manual cacao.", [DummyPlainObject class]);
    GHAssertTrue([configManager hasClass:[NSNotificationCenter class]], @"%@ is included as manual cacao.", [NSNotificationCenter class]);
    GHAssertFalse([configManager hasClass:[NSPredicate class]], @"%@ is not included.", [NSPredicate class]);
}

@end
