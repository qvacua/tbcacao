#import <Foundation/Foundation.h>

#import "TBBaseUnitTest.h"
#import "TBError.h"


@interface TBErrorTest : TBBaseUnitTest {
@private
    
}
@end

@implementation TBErrorTest


- (void)testInitWithMessage {
    TBError *error = [TBError errorWithMessage:@"ERROR"];
    GHAssertTrue([error.message isEqualToString:@"ERROR"], @"Error message is not correct.");
}


@end
