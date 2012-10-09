/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBBaseTest.h"
#import "TBObjcProperty.h"
#import "NSObject+TBCacao.h"
#import "DummyPlainObject.h"
#import "DummyPlainSubObject.h"

@interface NSObjectCategoryTest : TBBaseTest {} @end

@implementation NSObjectCategoryTest

- (void)testClassAsString {
    assertThat([DummyPlainObject classAsString], is(@"DummyPlainObject"));
    assertThat([DummyPlainSubObject classAsString], is(@"DummyPlainSubObject"));
}

- (void)testAllProperties {
    NSArray *properties = [DummyPlainSubObject objcProperties];
    assertThat(properties, hasSize(4));
    
    TBObjcProperty *firstProperty = [properties objectAtIndex:0];
    TBObjcProperty *secondProperty = [properties objectAtIndex:1];
    
    NSMutableSet *propertyClassSet = [NSMutableSet setWithCapacity:2];
    [propertyClassSet addObject:firstProperty.nameOfClass];
    [propertyClassSet addObject:secondProperty.nameOfClass];

    assertThat(propertyClassSet, hasItem(@"NSString"));
    assertThat(propertyClassSet, hasItem(@"NSArray"));

    NSMutableSet *propertyNameSet = [NSMutableSet setWithCapacity:2];
    [propertyNameSet addObject:firstProperty.name];
    [propertyNameSet addObject:secondProperty.name];
    
    assertThat(propertyNameSet, hasItem(@"stringProperty"));
    assertThat(propertyNameSet, hasItem(@"arrayProperty"));
}

- (void)testPropertiesWithoutSuperclass {
    NSArray *properties = [DummyPlainSubObject objcPropertiesWithoutSuperclass];
    assertThat(properties, hasSize(1));
    
    TBObjcProperty *property = [properties objectAtIndex:0];
    assertThat([property nameOfClass], is(@"NSArray"));
    assertThat([property name], is(@"arrayProperty"));
}

@end
