#import <objc/objc-runtime.h>

#import "NSObject+TBCacao.h"
#import "TBObjcProperty.h"


@implementation NSObject (TBCacao)


+ (NSString *)classAsString {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

+ (NSArray *)objcProperties {
    
    NSArray *result = [self objcPropertiesWithoutSuperclass];

    Class superclass = class_getSuperclass(self);

    if (superclass == [NSObject class]) {
        return result;
    }
    
    return [result arrayByAddingObjectsFromArray:[superclass objcProperties]];
}

+ (NSArray *)objcPropertiesWithoutSuperclass {
    
    unsigned int nrOfProps;
    objc_property_t *properties = class_copyPropertyList(self, &nrOfProps);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:nrOfProps];
    for (int i = 0; i < nrOfProps; i++) {
        TBObjcProperty *property = [[TBObjcProperty allocWithZone:nil] initWithProperty:properties[i]];
        [result addObject:property];
        [property release];
    }
    
    free(properties);

    return (NSArray *)result;
}


@end
