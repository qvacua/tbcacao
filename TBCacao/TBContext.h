/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <Foundation/Foundation.h>

@class TBBeanContainer;


@interface TBContext : NSObject

@property (strong, readonly) NSArray *beanContainers;

- (void)reautowireBeans;

- (id)init;
+ (TBContext *)sharedContext;

- (void)initContext;
- (void)addBeanContainer:(TBBeanContainer *)beanContainer;

- (TBBeanContainer *)beanContainerWithIdentifier:(NSString *)identifier;

-(id)beanWithClass:(Class)clazz;
-(id)beanWithIdentifier:(NSString *)identifier;
- (NSString *)identifierForBean:(id)bean;

- (void)autowireSeed:(id)seed;
- (void)replaceBeanWithIdentifier:(NSString *)identifier withBean:(id)bean;

@end
