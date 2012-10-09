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
    assertThat(@([beans count]), is(@2));
    assertThat(beans, consistsOfInAnyOrder(
        [TBBean objectWithIdentifier:@"EntryDao" bean:nil],
        [TBBean objectWithIdentifier:@"CoreDataManager" bean:nil]
    ));
}

- (void)testBeanWithIdentifier {
    TBBean *entryDaoBean = [context beanWithIdentifier:@"EntryDao"];
    assertThat([entryDaoBean.bean class], is([EntryDao class]));
}

- (void)testAutowireBeans {
    TBBean *entryDaoBean = [context beanWithIdentifier:@"EntryDao"];
    TBBean *coreDataManagerBean = [context beanWithIdentifier:@"CoreDataManager"];
    TBBean *entryCoreDataManagerBean = [context beanWithIdentifier:@"EntryCoreDataManager"];

    assertThat([entryCoreDataManagerBean.bean coreDataManager], is(coreDataManagerBean.bean));

    assertThat([entryDaoBean.bean coreDataManager], is(coreDataManagerBean.bean));
    assertThat([entryDaoBean.bean entryCoreDataManager], is(entryCoreDataManagerBean.bean));
}

@end
