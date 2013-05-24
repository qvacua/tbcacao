/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <Foundation/Foundation.h>
#import "BaseDao.h"

@class EntryCoreDataManager;
@protocol TBBean;

@interface EntryDao : BaseDao <TBBean>

@property EntryCoreDataManager *entryCoreDataManager;
@property NSWorkspace *workspace;

@end
