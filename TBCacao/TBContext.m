/**
 * Tae Won Ha
 * http://qvacua.com
 *
 * Copyright © 2012 Tae Won Ha. See LISENCE
 */

#import "TBContext.h"
#import "TBBean.h"
#import <objc/runtime.h>
#import "TBLog.h"

NSArray *subclasses_of_class(Class parentClass) {
    int classCount = objc_getClassList(NULL, 0);
    Class *classes = (Class *) malloc(sizeof(Class) * classCount);

    classCount = objc_getClassList(classes, classCount);
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < classCount; i++) {
        Class superClass = classes[i];

        do {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != parentClass);

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

static TBContext *sharedInstance;

@implementation TBContext {
    NSMutableArray *_beans;
    NSMutableArray *_beansToInit;
}

@synthesize beans = _beans;

#pragma mark NSObject
+ (void)load{
    [super load];

    sharedInstance = [[TBContext alloc] init];

    NSArray *classesOfBeans = subclasses_of_class([NSObject class]);
    [sharedInstance initializeBeans:classesOfBeans];

    [sharedInstance autowireBeans];
}

+ (TBContext *)sharedContext {
   return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _beans = [[NSMutableArray alloc] init];
    }

    return self;
}

#pragma mark Private
- (void)initializeBeans:(NSArray *)classes {
    for (Class cls in classes) {
        if (class_is_bean(cls)) {
            log4Debug(@"Bean found: %@", cls);

            NSString *className = @(class_getName(cls));
            id instance = [[NSClassFromString(className) alloc] init];
            TBBean *cacao = [[TBBean alloc] initWithIdentifier:className bean:instance];
            [sharedInstance addBean:cacao];
        }
    }
}

- (void)autowireBeans {
    for (TBBean *bean in self.beans) {

        Class superclass = [bean.bean class];
        do {

            unsigned int methodCount;
            Method *methods = class_copyMethodList(object_getClass(superclass), &methodCount);
            for (int i = 0; i < methodCount; i++) {
                NSString *methodName = [[NSString alloc] initWithCString:sel_getName(method_getName(methods[i])) encoding:NSUTF8StringEncoding];
                if ([methodName length] >= [TB_AUTOWIRE_METHOD_PREFIX length] - 1 && [[methodName substringToIndex:[TB_AUTOWIRE_METHOD_PREFIX length]] isEqualToString:TB_AUTOWIRE_METHOD_PREFIX]) {
                    log4Debug(@"%@", methodName);
                }
            }

            superclass = class_getSuperclass(superclass);

        } while (superclass && superclass != [NSObject class]);

    }
}

- (void)addBean:(TBBean *)cacao {
    for (TBBean *bean in self.beans) {
        if ([bean.identifier isEqualToString:cacao.identifier]) {
            log4Warn(@"Trying to add a bean with the same identifier '%@'.", bean.identifier);
            return;
        }
    }

    [_beans addObject:cacao];
}

@end
