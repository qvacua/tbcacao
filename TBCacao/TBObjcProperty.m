/*
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import "TBObjcProperty.h"
#import "NSString+TBCacao.h"

#import "TBLog.h"

@implementation TBObjcProperty


@synthesize name;
@dynamic    nameOfClass;
@synthesize clazz;
@synthesize readonly;
@synthesize type;


- (NSString *)nameOfClass {
    return [clazz description];
}

- (void) determineClass: (NSString *) attrString  {
    NSString *nameOfClass = [[NSString allocWithZone:nil] initWithString:[attrString substringWithRange:NSMakeRange(3, [attrString length] - 4)]];
    
    clazz = objc_getClass([nameOfClass UTF8String]);
    
    [nameOfClass release];    
}

- (void) determineTypeAndClass: (NSString *) attrString  {
    type = [attrString characterAtIndex:1];
    
    if (ObjectTBObjcProperty == type) {
        [self determineClass: attrString];
    }
    
    switch (type) {
        case IntTBObjcProperty:
        case LongTBObjcProperty:
        case DoubleTBObjcProperty:
        case FloatTBObjcProperty:
        case BoolTBObjcProperty:
        case ObjectTBObjcProperty:
            break;
            
        default:
            type = UnknownTBOjcProperty;
            log4Warn(@"The type %c is not supported yet.", type);
            break;
    }
}

- (void)parsePropertyAttribute:(objc_property_t)objc_property {
    name = [[NSString allocWithZone:nil] initWithUTF8String:property_getName(objc_property)];
    
    NSString *propAttrStr = [NSString stringWithUTF8String:property_getAttributes(objc_property)];
    
    log4Debug(@"Parsing the attribute string of an ObjC property: %@", propAttrStr);
    
    NSArray *attrStringArray = [propAttrStr componentsSeparatedByString:@","];
    
    for (NSString *attrString in attrStringArray) {
        char kind = [attrString characterAtIndex:0];
        
        switch (kind) {
            case 'T':
                [self determineTypeAndClass: attrString];
                break;
                
            case 'R':
                readonly = YES;
                break;
                
            default:
                break;
        }
    }
}

- (id)initWithProperty:(objc_property_t)objc_property {
    
    readonly = NO;
    type = UnknownTBOjcProperty;
    name = nil;
    clazz = nil;
    
    if ((self = [super init])) {
        [self parsePropertyAttribute:objc_property];
        
        if (type == ObjectTBObjcProperty && clazz == nil) {
            log4Warn(@"The class for the property could not be found in the Objc-runtime.");
            [self release];
            return nil;
        }
    }
    
    return self;
}

- (void)dealloc {
    [name release];
    
    [super dealloc];
}

@end
