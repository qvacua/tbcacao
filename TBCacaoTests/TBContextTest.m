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
            [TBBean objectWithIdentifier:@"NSDocumentController" bean:nil],
            [TBBean objectWithIdentifier:@"NSWorkspace" bean:nil],
            [TBBean objectWithIdentifier:@"NSFontManager" bean:nil]
    ));

    assertThat([context beanWithIdentifier:@"EntryDao"].targetSource, instanceOf([EntryDao class]));
    assertThat([context beanWithIdentifier:@"CoreDataManager"].targetSource, instanceOf([CoreDataManager class]));
    assertThat([context beanWithIdentifier:@"EntryCoreDataManager"].targetSource, instanceOf([EntryCoreDataManager class]));

    assertThat([context beanWithIdentifier:@"NSDocumentController"].targetSource, is([NSDocumentController sharedDocumentController]));
    assertThat([context beanWithIdentifier:@"NSWorkspace"].targetSource, is([NSWorkspace sharedWorkspace]));
    assertThat([context beanWithIdentifier:@"NSFontManager"].targetSource, is([NSFontManager sharedFontManager]));
}

- (void)testIdentifierForTargetSource {
    id targetSource = [context beanWithIdentifier:@"EntryDao"].targetSource;
    assertThat([context identifierForTargetSource:targetSource], is(@"EntryDao"));

    targetSource = [context beanWithIdentifier:@"NSDocumentController"].targetSource;
    assertThat([context identifierForTargetSource:targetSource], is(@"NSDocumentController"));
}

- (void)testBeanWithIdentifier {
    TBBean *entryDaoBean = [context beanWithIdentifier:@"EntryDao"];
    assertThat([entryDaoBean.targetSource class], is([EntryDao class]));
}

- (void)testTargetWithIdentifier {
    TBBean *entryDaoBeanTargetSource = [context targetSourceWithIdentifier:@"EntryDao"];
    assertThat([entryDaoBeanTargetSource class], is([EntryDao class]));
}

- (void)testAutowireBeans {
    TBBean *entryDaoBean = [context beanWithIdentifier:@"EntryDao"];
    TBBean *coreDataManagerBean = [context beanWithIdentifier:@"CoreDataManager"];
    TBBean *entryCoreDataManagerBean = [context beanWithIdentifier:@"EntryCoreDataManager"];

    assertThat([entryCoreDataManagerBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));

    assertThat([entryDaoBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));
    assertThat([entryDaoBean.targetSource entryCoreDataManager], is(entryCoreDataManagerBean.targetSource));
    assertThat([entryDaoBean.targetSource workspace], is([NSWorkspace sharedWorkspace]));
}

- (void)testAutowireSeed {
    DummySeed *seed = [[DummySeed alloc] init];

    [context autowireSeed:seed];
    assertThat(seed.coreDataManager, is([context beanWithIdentifier:@"CoreDataManager"].targetSource));
    assertThat(seed.workspace, is([NSWorkspace sharedWorkspace]));
}

- (void)testReplaceBean {
    CoreDataManager *mock = mock([CoreDataManager class]);

    [context replaceBeanWithIdentifier:@"CoreDataManager" withTargetSource:mock];
    assertThat([context beanWithIdentifier:@"CoreDataManager"].targetSource, is(mock));
}

- (void)testReautowireBeans {
    CoreDataManager *mock = mock([CoreDataManager class]);

    [context replaceBeanWithIdentifier:@"CoreDataManager" withTargetSource:mock];
    [context reautowireBeans];

    TBBean *entryDaoBean = [context beanWithIdentifier:@"EntryDao"];
    TBBean *coreDataManagerBean = [context beanWithIdentifier:@"CoreDataManager"];
    TBBean *entryCoreDataManagerBean = [context beanWithIdentifier:@"EntryCoreDataManager"];

    assertThat([entryCoreDataManagerBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));
    assertThat([entryDaoBean.targetSource coreDataManager], is(coreDataManagerBean.targetSource));
}

@end
