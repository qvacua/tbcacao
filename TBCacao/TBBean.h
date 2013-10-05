/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */


typedef enum {
    TBBeanScopeSingleton = 0,
    TBBeanScopePrototype,
} TBBeanScope;


/**
* If a class implements TBBean protocol, TBCacao will automatically instantiate it as a bean.
*/
@protocol TBBean
@end
