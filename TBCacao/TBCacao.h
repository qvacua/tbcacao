/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "TBContext.h"
#import "TBBean.h"
#import "TBManualBeanProvider.h"
#import "TBBeanContainer.h"
#import "TBInitializingBean.h"

#define TB_BEAN     + (BOOL)isBean { return YES; }

#define TB_AUTOWIRE_WITH_INSTANCE_VAR(propertyName, instanceName)       @synthesize propertyName = instanceName; \
                                                                        +(NSString *)TB_autowire_ ## propertyName { return  @#propertyName; }

#define TB_MANUALWIRE_WITH_INSTANCE_VAR(propertyName, instanceName)       @synthesize propertyName = instanceName; \
                                                                          +(NSString *)TB_manualwire_ ## propertyName { return  @#propertyName; }

#define TB_AUTOWIRE(propertyName)       @synthesize propertyName = _ ## propertyName ; \
                                        +(NSString *)TB_autowire_ ## propertyName { return  @#propertyName; }

#define TB_MANUALWIRE(propertyName)     @synthesize propertyName = _ ## propertyName ; \
                                        +(NSString *)TB_manualwire_ ## propertyName { return  @#propertyName; }
