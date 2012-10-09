/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import <Foundation/Foundation.h>

@class TBBean;

static NSString *const TB_AUTOWIRE_METHOD_PREFIX = @"TB_autowire_";

@interface TBContext : NSObject

@property (strong, readonly) NSArray *beans;

- (id)init;
+ (TBContext *)sharedContext;

- (void)initContext;
- (void)addBean:(TBBean *)bean;

- (TBBean *)beanWithIdentifier:(NSString *)identifier;
@end
