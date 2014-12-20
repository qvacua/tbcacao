/**
* Tae Won Ha
* http://qvacua.com
* https://github.com/qvacua
*
* See LICENSE
*/

#import "TBObjcProperty.h"
#import "TBLog.h"


@implementation TBObjcProperty {
  NSString *name;
  TBObjcPropertyType type;
  Class clazz;
  BOOL readonly;
}

@synthesize name;
@dynamic nameOfClass;
@synthesize clazz;
@synthesize readonly;
@synthesize type;

- (NSString *)nameOfClass {
  return [clazz description];
}

- (void)determineClass:(NSString *)attrString {
  if ([attrString length] <= 3) {
    clazz = nil;
    return;
  }

  NSString *nameOfClass = [[NSString alloc] initWithString:[attrString substringWithRange:NSMakeRange(3, [attrString length] - 4)]];

  if ([[nameOfClass substringToIndex:1] isEqualToString:@"<"]) {
    // id <SomeProtocol>
    clazz = nil;
    return;
  }

  if ([[nameOfClass substringToIndex:1] isEqualToString:@","]) {
    // id
    clazz = nil;
    return;
  }

  clazz = objc_getClass([nameOfClass UTF8String]);
}

- (void)determineTypeAndClass:(NSString *)attrString {
  type = (TBObjcPropertyType) [attrString characterAtIndex:1];

  if (ObjectTBObjcProperty == type) {
    [self determineClass:attrString];
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
    unichar kind = [attrString characterAtIndex:0];

    switch (kind) {
      case 'T':
        [self determineTypeAndClass:attrString];
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
  }

  return self;
}

@end
