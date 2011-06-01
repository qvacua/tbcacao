#import "DummyManualCacaoProvider.h"

#import "DummyPlainObject.h"
#import "DummyPlainSubObject.h"
#import "DummyManualCacao.h"

@implementation DummyManualCacaoProvider


@dynamic object;
@dynamic subObject;
@dynamic manualCacao;


- (DummyPlainObject *)object {
    DummyPlainObject *result = [[DummyPlainObject allocWithZone:nil] init];
    result.stringProperty = @"String";
    
    return result;
}

- (DummyPlainSubObject *)subObject {
    DummyPlainSubObject *result = [[DummyPlainSubObject allocWithZone:nil] init];
    result.stringProperty = @"String2";
    result.arrayProperty = [NSArray arrayWithObjects:@"first", @"second", nil];
    
    return result;
}

- (DummyManualCacao *)manualCacao {
    DummyManualCacao *result = [[DummyManualCacao allocWithZone:nil] init];
    
    return result;
}

- (void)dealloc {
    [object release];
    [subObject release];
    [manualCacao release];
    
    [super dealloc];
}


@end
