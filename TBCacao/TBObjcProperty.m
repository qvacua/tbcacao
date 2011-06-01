#import "TBObjcProperty.h"
#import "NSString+TBCacao.h"


@implementation TBObjcProperty


@synthesize name;
@synthesize nameOfClass;


- (NSString *)extractNameOfClass:(NSString *)propAttrString  {
    NSArray *propAttributes = [propAttrString componentsSeparatedByString:@","];
    
    for (NSString *attribute in propAttributes) {
        if ([attribute startsWithString:@"T@"]) {
            // Type attribute: T@"ClassName"
            return [attribute substringWithRange:NSMakeRange(3, [attribute length] - 4)];
        }
    }
    
    return nil;
}

- (id)initWithProperty:(objc_property_t)property {
    
    if ((self = [super init])) {
        name = [[NSString allocWithZone:nil] initWithUTF8String:property_getName(property)];
        NSString *propAttrString = [NSString stringWithUTF8String:property_getAttributes(property)];
        
        nameOfClass = [[NSString allocWithZone:nil] initWithString:[self extractNameOfClass: propAttrString]];
        
        if (! nameOfClass) {
            [self release];
            return nil;
        }
    }
    
    return self;
}

- (void)dealloc {
    [name release];
    [nameOfClass release];
    
    [super dealloc];
}

@end
