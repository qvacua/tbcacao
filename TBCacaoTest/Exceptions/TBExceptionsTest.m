#import <Foundation/Foundation.h>
#import "TBBaseUnitTest.h"

#import "TBConfigException.h"
#import "TBManualCacaoException.h"


@interface TBExceptionsTest : TBBaseUnitTest {
@private
    
}

@end

@implementation TBExceptionsTest


- (void)testExceptionNames {
    
    // TBConfigException
    GHAssertTrue([[[TBConfigException exceptionBuildNumberWithReason:@"REASON"] name] isEqualToString:TBConfigBuildNumberIncompatibleException], @"Name of %@ exception is not correct.", TBConfigBuildNumberIncompatibleException);
    GHAssertTrue([[[TBConfigException exceptionParsingConfigFileWithReason:@"REASON"] name] isEqualToString:TBConfigConfigFileBadlyFormattedException], @"Name of %@ exception is not correct.", TBConfigConfigFileBadlyFormattedException);
    GHAssertTrue([[[TBConfigException exceptionAbsentConfigManagerWithReason:@"REASON"] name] isEqualToString:TBConfigConfigManagerAbsentException], @"Name of %@ exception is not correct.", TBConfigConfigManagerAbsentException);
    GHAssertTrue([[[TBConfigException exceptionAbsentConfigFileNameWithReason:@"REASON"] name] isEqualToString:TBConfigBuildNumberIncompatibleException], @"Name of %@ exception is not correct.", TBConfigBuildNumberIncompatibleException);
    
    // TBManualCacaoException
    GHAssertTrue([[[TBManualCacaoException exceptionProviderWithReason:@"REASON"] name] isEqualToString:TBManualCacaoProviderClassNotFoundException], @"Name of %@ exception is not correct.", TBManualCacaoProviderClassNotFoundException);
    GHAssertTrue([[[TBManualCacaoException exceptionManualCacaoWithReason:@"REASON"] name] isEqualToString:TBManualCacaoClassNotFoundException], @"Name of %@ exception is not correct.", TBManualCacaoClassNotFoundException);
    
}


@end
