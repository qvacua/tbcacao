/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "TBBaseTest.h"
#import "NSString+TBCacao.h"

@interface NSStringCategoryTest : TBBaseTest  @end

@implementation NSStringCategoryTest {
@private
    NSString *string;
}

- (void)setUp {
    string = @"This is a real string.";
}

- (void)testStartsWith {
    assertThat(@([string startsWithString:@"Thi"]), is(@(YES)));
    assertThat(@([string startsWithString:@"This is a real string."]), is(@(YES)));
    assertThat(@([string startsWithString:@"thi"]), is(@(NO)));
}

@end
