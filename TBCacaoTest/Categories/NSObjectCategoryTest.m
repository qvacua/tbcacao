#import "TBBaseUnitTest.h"

#import "TBObjcProperty.h"
#import "NSObject+TBCacao.h"
#import "DummyPlainObject.h"
#import "DummyPlainSubObject.h"


@interface NSObjectCategoryTest : TBBaseUnitTest {} @end


@implementation NSObjectCategoryTest


- (void)testClassAsString {
    GHAssertTrue([[DummyPlainObject classAsString] isEqualToString:@"DummyPlainObject"], @"The class name should be DummyPlainObject.");
    GHAssertTrue([[DummyPlainSubObject classAsString] isEqualToString:@"DummyPlainSubObject"], @"The class name should be DummyPlainSubObject.");
}

- (void)testAllProperties {
    NSArray *properties = [DummyPlainSubObject objcProperties];
    
    GHAssertTrue([properties count] == 4, @"There should be 1 + 3 (superclass) properties alltogether for \"%@.\"", [DummyPlainSubObject classAsString]);
    
    TBObjcProperty *firstProperty = [properties objectAtIndex:0];
    TBObjcProperty *secondProperty = [properties objectAtIndex:1];
    
    NSMutableSet *propertyClassSet = [NSMutableSet setWithCapacity:2];
    [propertyClassSet addObject:firstProperty.nameOfClass];
    [propertyClassSet addObject:secondProperty.nameOfClass];
    
    GHAssertTrue([propertyClassSet containsObject:@"NSString"], @"NSString should be there.");
    GHAssertTrue([propertyClassSet containsObject:@"NSArray"], @"NSArray should be there.");

    NSMutableSet *propertyNameSet = [NSMutableSet setWithCapacity:2];
    [propertyNameSet addObject:firstProperty.name];
    [propertyNameSet addObject:secondProperty.name];
    
    GHAssertTrue([propertyNameSet containsObject:@"stringProperty"], @"stringProperty should be there.");
    GHAssertTrue([propertyNameSet containsObject:@"arrayProperty"], @"arrayProperty should be there.");
}

- (void)testPropertiesWithoutSuperclass {
    NSArray *properties = [DummyPlainSubObject objcPropertiesWithoutSuperclass];
    
    GHAssertTrue([properties count] == 1, @"There should be 1 property alltogether for \"%@\" without superclass.", [DummyPlainSubObject classAsString]);
    
    TBObjcProperty *property = [properties objectAtIndex:0];
    
    GHAssertTrue([property.nameOfClass isEqualToString:@"NSArray"], @"NSArray should be there.");
    GHAssertTrue([property.name isEqualToString:@"arrayProperty"], @"arrayProperty should be there.");
}


@end
