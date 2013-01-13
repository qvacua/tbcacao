/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "DummyManualBeanProvider.h"
#import "TBBeanContainer.h"

@implementation DummyManualBeanProvider

+ (NSArray *)beanContainers {
    static NSArray *cocoaBeans;

    if (cocoaBeans == nil) {
        cocoaBeans = @[
                [TBBeanContainer beanContainerWithBean:[NSWorkspace sharedWorkspace]],
                [TBBeanContainer beanContainerWithBean:[NSFontManager sharedFontManager]]
        ];
    }

    return cocoaBeans;
}

@end
