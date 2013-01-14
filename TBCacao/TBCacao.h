#import "TBContext.h"
#import "TBManualBeanProvider.h"
#import "TBBeanContainer.h"
#import "TBInitializingBean.h"

#define TB_BEAN     + (BOOL)isBean { return YES; }

#define TB_AUTOWIRE_WITH_INSTANCE_VAR(propertyName, instanceName)       @synthesize propertyName = instanceName; \
                                                                        +(NSString *)TB_autowire_ ## propertyName { return  @#propertyName; }
