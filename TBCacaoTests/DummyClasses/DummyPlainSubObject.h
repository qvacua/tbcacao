/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <Foundation/Foundation.h>
#import "DummyPlainObject.h"

@interface DummyPlainSubObject : DummyPlainObject {
@private
    NSArray *arrayProperty;
}

@property (retain) NSArray *arrayProperty;

@end
