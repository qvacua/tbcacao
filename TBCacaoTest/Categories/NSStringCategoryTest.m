#import "TBBaseUnitTest.h"

#import "NSString+TBCacao.h"


@interface NSStringCategoryTest : TBBaseUnitTest {
@private
    NSString *string;
}
@end


@implementation NSStringCategoryTest


- (void)setUp {
    string = @"This is a real string.";
}

- (void)testStartsWith {
    GHAssertTrue([string startsWithString:@"Thi"], @"String starts with \"Thi.\"");
    GHAssertTrue([string startsWithString:@"This is a real string."], @"String is equal, so should start with it.");
    GHAssertFalse([string startsWithString:@"thi"], @"String does not start with \"thi.\"");
}


@end
