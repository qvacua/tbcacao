//
//  DummyObject.h
//  ParAvion
//
//  Created by Tae Won Ha on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DummyPlainObject : NSObject {
@private
    NSString *stringProperty;
    int intProperty;
    
    int _customName;
}

@property (copy) NSString *stringProperty;
@property (nonatomic) int intProperty;
@property (readonly, nonatomic) int customName;

@end
