/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "DummyManualBeanProvider.h"
#import "TBBeanContainer.h"

@implementation DummyManualBeanProvider

+ (NSArray *)beans {
    static NSArray *cocoaBeans;

    if (cocoaBeans == nil) {
        cocoaBeans = @[
            [TBBeanContainer objectWithTargetSource:[NSWorkspace sharedWorkspace]],
            [TBBeanContainer objectWithTargetSource:[NSFontManager sharedFontManager]]
        ];
    }

    return cocoaBeans;
}

@end
