//
//  DummyPlainSubObject.h
//  ParAvion
//
//  Created by Tae Won Ha on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DummyPlainObject.h"


@interface DummyPlainSubObject : DummyPlainObject {
@private
    NSArray *arrayProperty;
}

@property (retain) NSArray *arrayProperty;

@end
