/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "TBBaseTest.h"
#import "TBCacao.h"

@interface TBBeanTest : TBBaseTest @end

@implementation TBBeanTest

- (void)testIsEqual {
    NSObject *obj1 = [[NSObject alloc] init];
    NSObject *obj2 = [[NSObject alloc] init];

    TBBeanContainer *bean1 = [TBBeanContainer beanContainerWithIdentifier:@"id" bean:obj1];
    TBBeanContainer *bean2 = [TBBeanContainer beanContainerWithIdentifier:@"id" bean:obj2];
    assertThat(@([bean1 isEqual:bean2]), is(@(YES)));

    TBBeanContainer *bean3 = [TBBeanContainer beanContainerWithIdentifier:@"id1" bean:obj1];
    TBBeanContainer *bean4 = [TBBeanContainer beanContainerWithIdentifier:@"id2" bean:obj1];
    assertThat(@([bean3 isEqual:bean4]), is(@(NO)));
}

@end
