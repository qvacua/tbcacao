/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LICENSE
 */

#import <objc/runtime.h>
#import <objc/message.h>
#import "TBContext.h"
#import "TBBean.h"
#import "NSObject+TBCacao.h"
#import "TBLog.h"
#import "TBObjcProperty.h"
#import "TBManualBeanProvider.h"

#pragma mark Static
NSArray *subclasses_of_class(Class parentClass) {
    int classCount = objc_getClassList(NULL, 0);
    Class *classes = (Class *) malloc(sizeof(Class) * classCount);

    classCount = objc_getClassList(classes, classCount);
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < classCount; i++) {
        Class superClass = classes[i];

        do {
            superClass = class_getSuperclass(superClass);
        } while (superClass && superClass != parentClass);

        if (superClass == nil) {
            continue;
        }

        [result addObject:classes[i]];
    }

    free(classes);

    return result;
}

NSArray *classes_conforming_to_protocol(Protocol *aProtocol) {
    int classCount = objc_getClassList(NULL, 0);
    Class *classes = (Class *) malloc(sizeof(Class) * classCount);

    classCount = objc_getClassList(classes, classCount);
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i < classCount; i++) {
        if (class_conformsToProtocol(classes[i], aProtocol)) {
            [result addObject:classes[i]];
        }
    }

    free(classes);

    return result;
}

BOOL class_is_bean(Class cls) {
    unsigned int methodCount;
    Method *methods = class_copyMethodList(object_getClass(cls), &methodCount);

    BOOL result = NO;
    for (int i = 0; i < methodCount; i++) {
        if (@selector(isBean) == method_getName(methods[i])) {
            result = YES;
            break;
        }
    }

    free(methods);

    return result;
}

@implementation TBContext {
    NSMutableArray *_beans;
    BOOL _contextInitialized;
}

@synthesize beans = _beans;

#pragma mark Public
- (void)initContext {
    if (_contextInitialized) {
        return;
    }

    _contextInitialized = YES;

    NSArray *classesOfBeans = subclasses_of_class([NSObject class]);
    [self initializeBeans:classesOfBeans];
    [self initializeManualBeans:classes_conforming_to_protocol(@protocol(TBManualBeanProvider))];

    [self autowireBeans];
}

- (void)addBean:(TBBean *)bean {
    for (TBBean *existingBean in self.beans) {
        if ([existingBean.identifier isEqualToString:bean.identifier]) {
            log4Warn(@"Trying to add a bean with the same identifier '%@'.", existingBean.identifier);
            return;
        }
    }

    [_beans addObject:bean];
}

- (TBBean *)beanWithIdentifier:(NSString *)identifier {
    for (TBBean *bean in self.beans) {
        if ([identifier isEqualToString:bean.identifier]) {
            return bean;
        }
    }

    return nil;
}

- (id)targetSourceWithClass:(Class)clazz {
    return [self targetSourceWithIdentifier:[clazz description]];
}

- (id)targetSourceWithIdentifier:(NSString *)identifier {
    return [self beanWithIdentifier:identifier].targetSource;
}

- (NSString *)identifierForTargetSource:(id)targetSource {
    for (TBBean *bean in self.beans) {
        if (targetSource == bean.targetSource) {
            return bean.identifier;
        }
    }

    return nil;
}

- (void)autowireSeed:(id)seed {
    [self autowireTargetSource:seed];
}

- (void)replaceBeanWithIdentifier:(NSString *)identifier withTargetSource:(id)targetSource {
    TBBean *newBean = [TBBean objectWithIdentifier:identifier bean:targetSource];

    TBBean *oldBean;
    for (TBBean *bean in self.beans) {
        if ([bean isEqual:newBean]) {
            oldBean = bean;
            break;
        }
    }

    [_beans removeObject:oldBean];
    [_beans addObject:newBean];
}

- (void)reautowireBeans {
    [self autowireBeans];
}

#pragma mark NSObject
- (id)init {
    self = [super init];
    if (self) {
        _beans = [[NSMutableArray alloc] init];
    }

    return self;
}

+ (TBContext *)sharedContext {
    static TBContext *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

#pragma mark Private
- (void)initializeBeans:(NSArray *)classes {
    for (Class cls in classes) {
        if (class_is_bean(cls)) {
            log4Debug(@"Bean of class '%@' found.", cls);

            NSString *className = [cls classAsString];
            id beanInstance = [[cls alloc] init];

            TBBean *cacao = [TBBean objectWithIdentifier:className bean:beanInstance];
            [self addBean:cacao];
        }
    }
}

- (void)initializeManualBeans:(NSArray *)classes {
    for (Class cls in classes) {
        log4Debug(@"Adding manual beans of %@", cls);
        [self addAllBeans:[cls beans]];
    }
}

- (void)addAllBeans:(NSArray *)manyBeans {
    [_beans addObjectsFromArray:manyBeans];
}

- (NSString *)classNameOfProperty:(NSString *)propertyName andClass:(Class)cls {
    NSArray *properties = [cls objcProperties];

    for (TBObjcProperty *property in properties) {
        if ([property.name isEqualToString:propertyName]) {
            return property.nameOfClass;
        }
    }

    return nil;
}

- (void)autowireBeans {
    for (TBBean *bean in self.beans) {
        [self autowireTargetSource:bean.targetSource];
    }
}

- (void)autowireTargetSource:(id)targetSource {
    Class superclass = [targetSource class];
    do {
        [self autowireTargetSource:targetSource asClass:superclass];
        superclass = class_getSuperclass(superclass);
    } while (superclass && superclass != [NSObject class]);
}

- (void)autowireTargetSource:(id)targetSource asClass:(Class)cls {
    unsigned int methodCount;
    Method *methods = class_copyMethodList(object_getClass(cls), &methodCount);

    for (int i = 0; i < methodCount; i++) {
        SEL sel = method_getName(methods[i]);
        NSString *methodName = [[NSString alloc] initWithCString:sel_getName(sel) encoding:NSUTF8StringEncoding];

        if ([methodName length] < [TB_AUTOWIRE_METHOD_PREFIX length]) {
            continue;
        }

        if ([[methodName substringToIndex:[TB_AUTOWIRE_METHOD_PREFIX length]] isEqualToString:TB_AUTOWIRE_METHOD_PREFIX] == NO) {
            continue;
        }

        id propertyKey = objc_msgSend(cls, sel);
        NSString *nameOfBeanClass = [self classNameOfProperty:propertyKey andClass:cls];

        id beanToBeAutowired = [self beanWithIdentifier:nameOfBeanClass].targetSource;
        [targetSource setValue:beanToBeAutowired forKey:propertyKey];

        log4Debug(@"Autowiring property '%@' of type '%@' from '%@'.", propertyKey, nameOfBeanClass, NSStringFromClass(cls));
    }

    free(methods);
}

@end
