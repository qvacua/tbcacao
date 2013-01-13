/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "TBBeanContainer.h"
#import "TBManualBeanProvider.h"
#import "AnotherManualBeanProvider.h"

@implementation AnotherManualBeanProvider

+ (NSArray *)beanContainers {
    static NSArray *manualBeans;

    if (manualBeans == nil) {
        manualBeans = @[
                [TBBeanContainer beanContainerWithBean:[NSDocumentController sharedDocumentController]]
        ];
    }

    return manualBeans;
}

@end
