/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBCacao.h"
#import "EntryCoreDataManager.h"
#import "CoreDataManager.h"

@implementation EntryCoreDataManager {
@private
    CoreDataManager *_coreDataManager;
}

TB_BEAN

TB_AUTOWIRE_WITH_INSTANCE_VAR(coreDataManager, _coreDataManager);

@end
