/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import "DummyManualBeanProvider.h"
#import "TBBean.h"

@implementation DummyManualBeanProvider

+ (NSArray *)beans {
    static NSArray *cocoaBeans;

    if (cocoaBeans == nil) {
        cocoaBeans = @[
            [TBBean objectWithTargetSource:[NSWorkspace sharedWorkspace]],
            [TBBean objectWithTargetSource:[NSFontManager sharedFontManager]]
        ];
    }

    return cocoaBeans;
}

@end
