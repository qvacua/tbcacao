/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "EntryDao.h"
#import "TBCacao.h"
#import "EntryCoreDataManager.h"

@implementation EntryDao {
@private
    EntryCoreDataManager *_entryCoreDataManager;
    NSWorkspace *_workspace;
}

TB_BEAN

TB_AUTOWIRE_WITH_INSTANCE_VAR(entryCoreDataManager, _entryCoreDataManager)
TB_AUTOWIRE_WITH_INSTANCE_VAR(workspace, _workspace);

@end
