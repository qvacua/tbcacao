/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <Foundation/Foundation.h>

@protocol TBInitializingBean;

@interface CoreDataManager : NSObject <TBInitializingBean>
@property (copy)NSString *stringProperty;
@end
