/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "DummyManualBeanProvider.h"
#import "TBBean.h"

@implementation DummyManualBeanProvider

+ (NSArray *)beans {
    static NSArray *cocoaBeans;

    if (cocoaBeans == nil) {
        cocoaBeans = @[
            [TBBean objectWithIdentifier:@"Workspace" bean:[NSWorkspace sharedWorkspace]],
            [TBBean objectWithIdentifier:@"FontManager" bean:[NSFontManager sharedFontManager]]
        ];
    }

    return cocoaBeans;
}

@end
