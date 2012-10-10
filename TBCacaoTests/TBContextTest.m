/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBBaseTest.h"
#import "TBCacao.h"
#import "EntryDao.h"
#import "CoreDataManager.h"
#import "EntryCoreDataManager.h"

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
    assertThat(@([beans count]), is(@(3 + 3)));
    assertThat(beans, consistsOfInAnyOrder(
        // annotation-based
        [TBBean objectWithIdentifier:@"EntryDao" bean:nil],
        [TBBean objectWithIdentifier:@"CoreDataManager" bean:nil],
        [TBBean objectWithIdentifier:@"EntryCoreDataManager" bean:nil],

        // manual
        [TBBean objectWithIdentifier:@"DocController" bean:nil],
        [TBBean objectWithIdentifier:@"Workspace" bean:nil],
        [TBBean objectWithIdentifier:@"FontManager" bean:nil]
    ));

    assertThat([context beanWithIdentifier:@"EntryDao"].targetSource, instanceOf([EntryDao class]));
    assertThat([context beanWithIdentifier:@"CoreDataManager"].targetSource, instanceOf([CoreDataManager class]));
    assertThat([context beanWithIdentifier:@"EntryCoreDataManager"].targetSource, instanceOf([EntryCoreDataManager class]));

    assertThat([context beanWithIdentifier:@"DocController"].targetSource, is([NSDocumentController sharedDocumentController]));
    assertThat([context beanWithIdentifier:@"Workspace"].targetSource, is([NSWorkspace sharedWorkspace]));
    assertThat([context beanWithIdentifier:@"FontManager"].targetSource, is([NSFontManager sharedFontManager]));
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
