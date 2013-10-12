# TheobromaCacao — TBCacao

## About

TBCacao is a small and simple Cocoa framework for dependency injection.

## CocoaPods
For iOS there is a CocoaPod:
```
pod 'TBCacaoIOS'
```
The CocoaPod for OS X will be available soon.

## Example Project
My other project [Qmind](https://github.com/qvacua/qmind) — a mind mapping app for OS X compatible with FreeMind — uses TBCacao quite extensively. Have a look for a real life example.

## Usage

First, include `TBCacao` in your project by either adding it as a Framework or copying all `TBCacao` classes into your project. To initialize `TBCacao` you add the following line to `main.m` before you return:
```objc
[[TBContext sharedContext] initContext];
```

### TBBean

Assume that we have the following two classes:
* `MyLayoutManager`
* `MyDrawingManager`

Assume further that you want to have `MyLayoutManager` automatically injected—autowired in the language of Spring—in `MyDrawingManager`. The two classes look as follows

#### MyLayoutManager
```objc
@interface MyLayoutManager : NSObject <TBBean>

- (void)doLayout;

@end

@implementation MyLayoutManager

- (void)doLayout {
  NSLog(@"doLayout");
}

@end
```

#### MyDrawManager
```objc
@interface MyDrawManager : NSObject <TBBean>

@property (weak) MyLayoutManager *layoutManager;

- (void)doDraw;

@end

@implementation MyDrawManager

TB_AUTOWIRE(layoutManager)

- (void)doDraw {
	[self.layoutManager doLayout];
}

@end
```

The protocol `TBBean` marks both classes as beans such that they are scanned by `TBCacao`. The line `TB_AUTOWIRE(layoutManager)` lets `TBCacao` automatically set the property `layoutManager` with an instance of `MyLayoutManager`.

### TBManualBeanProvider

Oftentimes you use singltons of Foundation, AppKit/UIKit or other 3rd party frameworks in your classes. For many purposes it is beneficial to have them injected, ie not call messages like `[SomeManager sharedManager]`. This can easily limit the unit-testability of your classes. Let's assume that you have `MyManager` and this class uses `[NSNotificationCenter defaultCenter]`. To inject the default notification center, you do the following

#### MyManualBeanProvider
```objc
@interface MyManualBeanProvider : NSObject <TBManualBeanProvider>
@end

@implementation MyManualBeanProvider

+ (NSArray *)beanContainers {
    static NSArray *manualBeans;

    if (manualBeans == nil) {
        manualBeans = @[
                [TBBeanContainer beanContainerWithBean:[NSNotificationCenter defaultCenter]],
                [TBBeanContainer beanContainerWithBean:[SomeOtherManager sharedManager]],
        ];
    }

    return manualBeans;
}

@end
```

#### MyManager
```objc
@interface MyManager: NSObject <TBBean>

@property (weak) NSNotificationCenter *notificationCenter;

@end

@implementation MyManager

TB_AUTOWIRE(notificationCenter)

@end
```

Now, you can easily mock the notification center in your unit test for `MyManager`.

Since `TBCacao` automatically scans all classes implementing the protocol `TBManualBeanProvider`, you don't need an interface file; put both `@interface` and `@implementation` in `MyManualBeanProvider.m`.

- - -

TODO: Describe `TB_MANUALWIRE`.
