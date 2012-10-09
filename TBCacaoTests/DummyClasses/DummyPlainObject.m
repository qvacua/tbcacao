/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "DummyPlainObject.h"

@implementation DummyPlainObject

@synthesize stringProperty;
@synthesize intProperty;
@synthesize customName = _customName;

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
