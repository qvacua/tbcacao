/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

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
