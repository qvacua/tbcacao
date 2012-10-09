/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBContext.h"
#import "TBBean.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+TBCacao.h"
#import "TBLog.h"
#import "TBObjcProperty.h"

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

BOOL class_is_bean(Class cls) {
    unsigned int methodCount;
    Method *methods = class_copyMethodList(object_getClass(cls), &methodCount);

    for (int i = 0; i < methodCount; i++) {
        if (@selector(isBean) == method_getName(methods[i])) {
            return YES;
        }
    }

    return NO;
}

@implementation TBContext {
    NSMutableArray *_beans;
}

@synthesize beans = _beans;

#pragma mark Public
- (void)initContext {
    NSArray *classesOfBeans = subclasses_of_class([NSObject class]);
    [self initializeBeans:classesOfBeans];

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

- (NSString *)classNameOfProperty:(NSString *)propertyName andClass:(Class)cls {
    NSArray *properties = [cls objcProperties];
    for (TBObjcProperty *objcProperty in properties) {
        if ([objcProperty.name isEqualToString:propertyName]) {
            return objcProperty.nameOfClass;
        }
    }

    return nil;
}

- (void)autowireBeans {
    for (TBBean *bean in self.beans) {
        Class superclass = [bean.targetSource class];
        do {
            [self autowireBean:bean ofClass:superclass];
            superclass = class_getSuperclass(superclass);
        } while (superclass && superclass != [NSObject class]);
    }
}

- (void)autowireBean:(TBBean *)bean ofClass:(Class)cls {
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
        log4Debug(@"Property '%@' of type '%@' from '%@' to autowire found", propertyKey, nameOfBeanClass, NSStringFromClass(cls));

        [bean.targetSource setValue:[self beanWithIdentifier:nameOfBeanClass].targetSource forKey:propertyKey];
        break;
    }

    free(methods);
}

@end
