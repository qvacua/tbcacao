/**
* Tae Won Ha
* http://qvacua.com
* https://github.com/qvacua
*
* See LICENSE
*/

@protocol TBInitializingBean <NSObject>

@required
- (void)postConstruct;

@optional
- (NSUInteger)TB_postConstructOrder;

@end
