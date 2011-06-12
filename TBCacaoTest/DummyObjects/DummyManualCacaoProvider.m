#import "DummyManualCacaoProvider.h"

#import "DummyPlainObject.h"
#import "DummyPlainSubObject.h"
#import "DummyManualCacao.h"

@implementation DummyManualCacaoProvider


@synthesize object;
@synthesize subObject;
@synthesize manualCacao;


- (id)init {
    if ((self = [super init])) {
        object = [[DummyPlainObject allocWithZone:nil] init];
        object.stringProperty = @"String";
        
        subObject = [[DummyPlainSubObject allocWithZone:nil] init];
        subObject.stringProperty = @"String2";
        subObject.arrayProperty = [NSArray arrayWithObjects:@"first", @"second", nil];
        
        manualCacao = [[DummyManualCacao allocWithZone:nil] init];
    }
    
    return self;
}

- (void)dealloc {
    [object release];
    [subObject release];
    [manualCacao release];
    
    [super dealloc];
}


@end
