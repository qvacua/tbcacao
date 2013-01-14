/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "TBCacao.h"
#import "EntryCoreDataManager.h"
#import "CoreDataManager.h"
#import "TBInitializingBean.h"

@implementation EntryCoreDataManager {
    CoreDataManager *_coreDataManager;
    NSString *_stringProperty;
}

TB_BEAN
TB_POSTCONSTRUCT_ORDER(2000)
TB_AUTOWIRE_WITH_INSTANCE_VAR(coreDataManager, _coreDataManager);

@synthesize stringProperty = _stringProperty;

- (void)postConstruct {
    _stringProperty = self.coreDataManager.stringProperty;
}

@end
