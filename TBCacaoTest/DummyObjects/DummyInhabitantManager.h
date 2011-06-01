//
//  DummyInhabitantManager.h
//  ParAvion
//
//  Created by Tae Won Ha on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DummyCityManager;

@interface DummyInhabitantManager : NSObject {
@private
    DummyCityManager *cityManager;
}

@property (assign, nonatomic) DummyCityManager *cityManager;

@end
