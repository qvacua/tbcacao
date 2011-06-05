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
    NSNotificationCenter *notificationCenter;
}

@property (assign, nonatomic) DummyCityManager *cityManager;
@property (assign, nonatomic) NSNotificationCenter *notificationCenter;

@end
