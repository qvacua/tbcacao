#import "TBBaseUnitTest.h"

#import "TBObjcProperty.h"
#import "NSObject+TBCacao.h"
#import "DummyPlainObject.h"


@interface TBObjcPropertyTest : TBBaseUnitTest {} @end


@implementation TBObjcPropertyTest

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testObjcPropertyInit {
    
    unsigned int nrOfProps;
    objc_property_t *properties = class_copyPropertyList([DummyPlainObject class], &nrOfProps);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:nrOfProps];
    for (int i = 0; i < nrOfProps; i++) {
        TBObjcProperty *property = [[TBObjcProperty allocWithZone:nil] initWithProperty:properties[i]];
        [result addObject:property];
        [property release];
    }
    
    free(properties);
    
    GHAssertTrue(([result count] == 1), @"There should be only one property for %@.", [DummyPlainObject classAsString]);
    
    TBObjcProperty *stringProperty = [result objectAtIndex:0];
    
    GHAssertTrue([[stringProperty name] isEqualToString:@"stringProperty"], @"The name of the property should be \"stringProperty.\"");
    GHAssertTrue([[stringProperty nameOfClass] isEqualToString:@"NSString"], @"The class of the property should be \"NSString.\"");
}

@end
