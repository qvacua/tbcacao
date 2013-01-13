/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "TBBaseTest.h"
#import "TBCacao.h"
#import "EntryDao.h"
#import "CoreDataManager.h"
#import "EntryCoreDataManager.h"
#import "DummySeed.h"

@interface TBContextTest : TBBaseTest
@end

@implementation TBContextTest {
    TBContext *context;
    NSArray *beans;
}

- (void)setUp {
    context = [[TBContext alloc] init];
    [context initContext];

    beans = context.beanContainers;
}

- (void)testInitContext {
    assertThat(@([beans count]), is(@(3 + 3)));
    assertThat(beans, consistsOfInAnyOrder(
            // annotation-based
            [TBBeanContainer beanContainerWithIdentifier:@"EntryDao" bean:nil],
            [TBBeanContainer beanContainerWithIdentifier:@"CoreDataManager" bean:nil],
            [TBBeanContainer beanContainerWithIdentifier:@"EntryCoreDataManager" bean:nil],

            // manual
            [TBBeanContainer beanContainerWithIdentifier:@"NSDocumentController" bean:nil],
            [TBBeanContainer beanContainerWithIdentifier:@"NSWorkspace" bean:nil],
            [TBBeanContainer beanContainerWithIdentifier:@"NSFontManager" bean:nil]
    ));

    assertThat([context beanContainerWithIdentifier:@"EntryDao"].targetSource, instanceOf([EntryDao class]));
    assertThat([context beanContainerWithIdentifier:@"CoreDataManager"].targetSource, instanceOf([CoreDataManager class]));
    assertThat([context beanContainerWithIdentifier:@"EntryCoreDataManager"].targetSource, instanceOf([EntryCoreDataManager class]));

    assertThat([context beanContainerWithIdentifier:@"NSDocumentController"].targetSource, is([NSDocumentController sharedDocumentController]));
    assertThat([context beanContainerWithIdentifier:@"NSWorkspace"].targetSource, is([NSWorkspace sharedWorkspace]));
    assertThat([context beanContainerWithIdentifier:@"NSFontManager"].targetSource, is([NSFontManager sharedFontManager]));
}

- (void)testIdentifierForTargetSource {
    id targetSource = [context beanContainerWithIdentifier:@"EntryDao"].targetSource;
    assertThat([context identifierForBean:targetSource], is(@"EntryDao"));

    targetSource = [context beanContainerWithIdentifier:@"NSDocumentController"].targetSource;
    assertThat([context identifierForBean:targetSource], is(@"NSDocumentController"));
}

- (void)testBeanWithIdentifier {
    TBBeanContainer *entryDaoBean = [context beanContainerWithIdentifier:@"EntryDao"];
    assertThat([entryDaoBean.targetSource class], is([EntryDao class]));
}

- (void)testTargetWithIdentifier {
    TBBeanContainer *entryDaoBeanTargetSource = [context beanWithIdentifier:@"EntryDao"];
    assertThat([entryDaoBeanTargetSource class], is([EntryDao class]));
}

- (void)testTargetWithClass {
    TBBeanContainer *entryDaoBeanTargetSource = [context beanWithClass:[EntryDao class]];
    assertThat([entryDaoBeanTargetSource class], is([EntryDao class]));
}

- (void)testAutowireBeans {
    TBBeanContainer *entryDaoBean = [context beanContainerWithIdentifier:@"EntryDao"];
    TBBeanContainer *coreDataManagerBean = [context beanContainerWithIdentifier:@"CoreDataManager"];
    TBBeanContainer *entryCoreDataManagerBean = [context beanContainerWithIdentifier:@"EntryCoreDataManager"];

    assertThat([entryCoreDataManagerBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));

    assertThat([entryDaoBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));
    assertThat([entryDaoBean.targetSource entryCoreDataManager], is(entryCoreDataManagerBean.targetSource));
    assertThat([entryDaoBean.targetSource workspace], is([NSWorkspace sharedWorkspace]));
}

- (void)testAutowireSeed {
    DummySeed *seed = [[DummySeed alloc] init];

    [context autowireSeed:seed];
    assertThat(seed.coreDataManager, is([context beanContainerWithIdentifier:@"CoreDataManager"].targetSource));
    assertThat(seed.workspace, is([NSWorkspace sharedWorkspace]));
}

- (void)testReplaceBean {
    CoreDataManager *mock = mock([CoreDataManager class]);

    [context replaceBeanWithIdentifier:@"CoreDataManager" withBean:mock];
    assertThat([context beanContainerWithIdentifier:@"CoreDataManager"].targetSource, is(mock));
}

- (void)testReautowireBeans {
    CoreDataManager *mock = mock([CoreDataManager class]);

    [context replaceBeanWithIdentifier:@"CoreDataManager" withBean:mock];
    [context reautowireBeans];

    TBBeanContainer *entryDaoBean = [context beanContainerWithIdentifier:@"EntryDao"];
    TBBeanContainer *coreDataManagerBean = [context beanContainerWithIdentifier:@"CoreDataManager"];
    TBBeanContainer *entryCoreDataManagerBean = [context beanContainerWithIdentifier:@"EntryCoreDataManager"];

    assertThat([entryCoreDataManagerBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));
    assertThat([entryDaoBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));
}

@end
