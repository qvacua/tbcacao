/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBBaseTest.h"
#import "TBCacao.h"

@interface TBBeanTest : TBBaseTest @end

@implementation TBBeanTest

- (void)testIsEqual {
    NSObject *obj1 = [[NSObject alloc] init];
    NSObject *obj2 = [[NSObject alloc] init];

    TBBean *bean1 = [TBBean objectWithIdentifier:@"id" bean:obj1];
    TBBean *bean2 = [TBBean objectWithIdentifier:@"id" bean:obj2];
    assertThat(@([bean1 isEqual:bean2]), is(@(YES)));

    TBBean *bean3 = [TBBean objectWithIdentifier:@"id1" bean:obj1];
    TBBean *bean4 = [TBBean objectWithIdentifier:@"id2" bean:obj1];
    assertThat(@([bean3 isEqual:bean4]), is(@(NO)));
}

@end
