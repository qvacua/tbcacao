/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBCacao.h"
#import "DummySeed.h"
#import "CoreDataManager.h"

@implementation DummySeed {
@private
    CoreDataManager *_coreDataManager;
    NSWorkspace *_workspace;
}

TB_AUTOWIRE_WITH_INSTANCE_VAR(coreDataManager, _coreDataManager)
TB_AUTOWIRE_WITH_INSTANCE_VAR(workspace, _workspace);

@end