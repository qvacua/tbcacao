/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "TBCacao.h"
#import "TBInitializingBean.h"
#import "CoreDataManager.h"

@implementation CoreDataManager {
    NSString *stringProperty;
}

TB_BEAN
TB_POSTCONSTRUCT_ORDER(1000)

@synthesize stringProperty;

- (void)postConstruct {
    stringProperty = @"PostConstruct";
}

@end
