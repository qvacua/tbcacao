#import "DummyPlainObject.h"


@implementation DummyPlainObject


@synthesize stringProperty;
@synthesize intProperty;
@synthesize customName = _customName;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
