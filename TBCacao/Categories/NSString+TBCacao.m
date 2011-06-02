/*
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import "NSString+TBCacao.h"


@implementation NSString (TBCacao)


- (BOOL)startsWithString:(NSString *)str {
    NSUInteger length = [str length];
    NSComparisonResult result = [self compare:str options:NSLiteralSearch range:NSMakeRange(0, length)];
    
    return (result == NSOrderedSame) ? YES : NO;
}


@end
