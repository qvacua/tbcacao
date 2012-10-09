/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBBaseTest.h"
#import "TBCacao.h"
#import "EntryDao.h"

@interface TBContextTest : TBBaseTest @end

@implementation TBContextTest {
    TBContext *context;
    NSArray *beans;
}

- (void)setUp {
    context = [[TBContext alloc] init];
    [context initContext];

    beans = context.beans;
}

- (void)testInitContext {
    assertThat(@([beans count]), is(@3));
    assertThat(beans, consistsOfInAnyOrder(
        [TBBean objectWithIdentifier:@"EntryDao" bean:nil],
        [TBBean objectWithIdentifier:@"CoreDataManager" bean:nil],
        [TBBean objectWithIdentifier:@"EntryCoreDataManager" bean:nil]
    ));
}

- (void)testBeanWithIdentifier {
    TBBean *entryDaoBean = [context beanWithIdentifier:@"EntryDao"];
    assertThat([entryDaoBean.targetSource class], is([EntryDao class]));
}

- (void)testAutowireBeans {
    TBBean *entryDaoBean = [context beanWithIdentifier:@"EntryDao"];
    TBBean *coreDataManagerBean = [context beanWithIdentifier:@"CoreDataManager"];
    TBBean *entryCoreDataManagerBean = [context beanWithIdentifier:@"EntryCoreDataManager"];

    assertThat([entryCoreDataManagerBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));

    assertThat([entryDaoBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));
    assertThat([entryDaoBean.targetSource entryCoreDataManager], is(entryCoreDataManagerBean.targetSource));
}

@end
