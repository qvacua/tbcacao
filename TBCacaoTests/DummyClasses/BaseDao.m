/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <TBCacao/TBCacao.h>
#import "BaseDao.h"
#import "CoreDataManager.h"

@implementation BaseDao {
@private
    CoreDataManager *_coreDataManager;
}

TB_AUTOWIRE_WITH_INSTANCE_VAR(coreDataManager, _coreDataManager);

@end
