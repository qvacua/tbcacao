/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBBaseTest.h"

#import "TBObjcProperty.h"
#import "NSObject+TBCacao.h"
#import "DummyPropertyObject.h"
#import "DummyPlainObject.h"

@interface TBObjcPropertyTest : TBBaseTest @end

@implementation TBObjcPropertyTest

- (void)testObjcPropertyInit {
    unsigned int nrOfProps;
    objc_property_t *properties = class_copyPropertyList([DummyPropertyObject class], &nrOfProps);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:nrOfProps];
    for (int i = 0; i < nrOfProps; i++) {
        TBObjcProperty *property = [[TBObjcProperty allocWithZone:nil] initWithProperty:properties[i]];
        [result addObject:property];
    }
    
    free(properties);
    
    assertThat(result, hasSize(7));
    
    TBObjcProperty *boolProperty = [result objectAtIndex:0];
    assertThat(boolProperty.name, is(@"boolProperty"));
    assertThat(@(boolProperty.type), is(@(BoolTBObjcProperty)));

    TBObjcProperty *intProperty = [result objectAtIndex:1];
    assertThat(intProperty.name, is(@"intProperty"));
    assertThat(@(intProperty.type), is(@(IntTBObjcProperty)));

    TBObjcProperty *longProperty = [result objectAtIndex:2];
    assertThat(longProperty.name, is(@"longProperty"));
    assertThat(@(longProperty.type), is(@(LongTBObjcProperty)));

    TBObjcProperty *floatProperty = [result objectAtIndex:3];
    assertThat(floatProperty.name, is(@"floatProperty"));
    assertThat(@(floatProperty.type), is(@(FloatTBObjcProperty)));

    TBObjcProperty *doubleProperty = [result objectAtIndex:4];
    assertThat(doubleProperty.name, is(@"doubleProperty"));
    assertThat(@(doubleProperty.type), is(@(DoubleTBObjcProperty)));

    TBObjcProperty *objectProperty = [result objectAtIndex:5];
    assertThat(objectProperty.name, is(@"objectProperty"));
    assertThat(@(objectProperty.type), is(@(ObjectTBObjcProperty)));
    assertThat(objectProperty.clazz, is([DummyPlainObject class]));
    assertThat(objectProperty.nameOfClass, is([DummyPlainObject classAsString]));

    TBObjcProperty *unknownProperty = [result objectAtIndex:6];
    assertThat(unknownProperty.name, is(@"voidPointerProperty"));
    assertThat(@(unknownProperty.type), is(@(UnknownTBOjcProperty)));
}

@end
