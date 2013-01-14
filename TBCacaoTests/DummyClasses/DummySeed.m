/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "TBCacao.h"
#import "DummySeed.h"
#import "CoreDataManager.h"

@implementation DummySeed {
@private
    CoreDataManager *_coreDataManager;
    NSWorkspace *_workspace;
}

TB_MANUALWIRE_WITH_INSTANCE_VAR(coreDataManager, _coreDataManager)
TB_MANUALWIRE_WITH_INSTANCE_VAR(workspace, _workspace)

@end
