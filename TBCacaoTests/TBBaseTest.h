/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define hasSize(number) hasCount(equalToInt(number))
#define consistsOf(...) contains(__VA_ARGS__, nil)
#define consistsOfInAnyOrder(...) containsInAnyOrder(__VA_ARGS__, nil)

@interface TBBaseTest : SenTestCase

@end
