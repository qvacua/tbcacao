#import "TBBaseUnitTest.h"

#import "TBObjcProperty.h"
#import "NSObject+TBCacao.h"
#import "DummyPropertyObject.h"
#import "DummyPlainObject.h"


@interface TBObjcPropertyTest : TBBaseUnitTest {} @end


@implementation TBObjcPropertyTest

- (void)testObjcPropertyInit {
    
    unsigned int nrOfProps;
    objc_property_t *properties = class_copyPropertyList([DummyPropertyObject class], &nrOfProps);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:nrOfProps];
    for (int i = 0; i < nrOfProps; i++) {
        TBObjcProperty *property = [[TBObjcProperty allocWithZone:nil] initWithProperty:properties[i]];
        [result addObject:property];
        [property release];
    }
    
    free(properties);
    
    GHAssertTrue(([result count] == 7), @"There should be 7 properties for %@.", [DummyPropertyObject classAsString]);
    
    TBObjcProperty *boolProperty = [result objectAtIndex:0];
    GHAssertTrue([boolProperty.name isEqualToString:@"boolProperty"], @"The name of the property should be \"boolProperty.\"");
    GHAssertTrue(boolProperty.type == BoolTBObjcProperty, @"The type of the property should be BOOL.");

    TBObjcProperty *intProperty = [result objectAtIndex:1];
    GHAssertTrue([intProperty.name isEqualToString:@"intProperty"], @"The name of the property should be \"intProperty.\"");
    GHAssertTrue(intProperty.type == IntTBObjcProperty, @"The type of the property should be int.");

    TBObjcProperty *longProperty = [result objectAtIndex:2];
    GHAssertTrue([longProperty.name isEqualToString:@"longProperty"], @"The name of the property should be \"longProperty.\"");
    GHAssertTrue(longProperty.type == LongTBObjcProperty, @"The type of the property should be long long.");

    TBObjcProperty *floatProperty = [result objectAtIndex:3];
    GHAssertTrue([floatProperty.name isEqualToString:@"floatProperty"], @"The name of the property should be \"floatProperty.\"");
    GHAssertTrue(floatProperty.type == FloatTBObjcProperty, @"The type of the property should be float.");

    TBObjcProperty *doubleProperty = [result objectAtIndex:4];
    GHAssertTrue([doubleProperty.name isEqualToString:@"doubleProperty"], @"The name of the property should be \"doubleProperty.\"");
    GHAssertTrue(doubleProperty.type == DoubleTBObjcProperty, @"The type of the property should be double.");

    TBObjcProperty *objectProperty = [result objectAtIndex:5];
    GHAssertTrue([objectProperty.name isEqualToString:@"objectProperty"], @"The name of the property should be \"objectProperty.\"");
    GHAssertTrue(objectProperty.type == ObjectTBObjcProperty, @"The type of the property should be object.");
    GHAssertTrue(objectProperty.clazz == [DummyPlainObject class], @"The clazz of objectProperty should be equal to [DummyPropertyObject clazz.");
    GHAssertTrue([objectProperty.nameOfClass isEqualToString:[DummyPlainObject classAsString]], @"The name of the class of objectProperty should be equal to \"DummyPropertyObjct\"");

    TBObjcProperty *unknownProperty = [result objectAtIndex:6];
    GHAssertTrue([unknownProperty.name isEqualToString:@"voidPointerProperty"], @"The name of the property should be \"voidPointerProperty.\"");
    GHAssertTrue(unknownProperty.type == UnknownTBOjcProperty, @"The type of the property should be unknown.");

}

@end
