//
//  DummyObject.m
//  ParAvion
//
//  Created by Tae Won Ha on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DummyPlainObject.h"


@implementation DummyPlainObject


@synthesize stringProperty;
@synthesize intProperty;
@synthesize customName = _customName;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
