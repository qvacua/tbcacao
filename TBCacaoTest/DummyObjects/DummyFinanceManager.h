//
//  DummyFinanceManager.h
//  ParAvion
//
//  Created by Tae Won Ha on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DummyPlainObject.h"

@interface DummyFinanceManager : NSObject {
@private
    DummyPlainObject *object;
}

@property (assign, nonatomic) DummyPlainObject *object;

@end
