/**
 * Tae Won Ha
 * http://qvacua.com
 * https://bitbucket.org/qvacua
 *
 * See LICENSE
 */

#define TB_POSTCONSTRUCT_ORDER(x) - (NSUInteger)postConstructOrder { return (NSUInteger) x; }

@protocol TBInitializingBean <NSObject>

@required
- (void)postConstruct;

@optional
- (NSUInteger)postConstructOrder;

@end
