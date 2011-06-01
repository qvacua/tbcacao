//
//  TBBaseUnitTest.m
//  ParAvion
//
//  Created by Tae Won Ha on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TBBaseUnitTest.h"


@implementation TBBaseUnitTest

- (BOOL)shouldRunOnMainThread {
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES
    return NO;
}

- (void)setUpClass {
    // Run at start of all tests in the class
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
    // Run before each test method
}

- (void)tearDown {
    // Run after each test method
}

@end
