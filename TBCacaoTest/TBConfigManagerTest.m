#import <Foundation/Foundation.h>

#import "TBBaseUnitTest.h"
#import "TBConfigManager.h"
#import "TBError.h"


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
    GHAssertTrue([configManager.configManualCacaos count] == 3, @"The number of manual cacaos is 3.");
    GHAssertTrue([configManager.configManualCacaoProviders count] == 1, @"The number of manual cacao provider is 1.");
}

@end
