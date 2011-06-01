//
//  DummyManualCacao.h
//  ParAvion
//
//  Created by Tae Won Ha on 5/29/11.
//  Copyright 2011 TNG Technology Consulting GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DummyStateManager;

@interface DummyManualCacao : NSObject {
@private
    DummyStateManager *stateManager;
}

@property (assign, nonatomic) DummyStateManager *stateManager;

@end
