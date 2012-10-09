/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBBaseTest.h"
#import "TBCacao.h"

@interface TBContextTest : TBBaseTest @end

@implementation TBContextTest

- (void)testInitContext {
    TBContext *context = [[TBContext alloc] init];
    [context initContext];

    NSArray *beans = context.beans;

    assertThat(@([beans count]), is(@2));
    assertThat(beans, consistsOfInAnyOrder(
        [TBBean objectWithIdentifier:@"EntryDao" bean:nil],
        [TBBean objectWithIdentifier:@"CoreDataManager" bean:nil]
    ));
}

@end
