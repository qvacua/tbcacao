/**
* Tae Won Ha
* http://qvacua.com
* https://github.com/qvacua
*
* See LICENSE
*/

#import "NSString+TBCacao.h"


@implementation NSString (TBCacao)

- (BOOL)startsWithString:(NSString *)str {
  NSUInteger length = [str length];
  NSComparisonResult result = [self compare:str options:NSLiteralSearch range:NSMakeRange(0, length)];

  return result == NSOrderedSame;
}

@end
