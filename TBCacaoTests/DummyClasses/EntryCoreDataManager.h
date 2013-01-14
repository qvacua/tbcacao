/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <Foundation/Foundation.h>

@class CoreDataManager;
@protocol TBInitializingBean;

@interface EntryCoreDataManager : NSObject <TBInitializingBean>

@property CoreDataManager *coreDataManager;

@property (copy) NSString *stringProperty;

@end
