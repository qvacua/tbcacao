# TheobromaCacao — TBCacao

## About

TBCacao is a small and simple Cocoa framework for dependency injection.

## Example Project
My other project [Qmind](https://github.com/qvacua/qmind) — a mind mapping app for OS X compatible with FreeMind — uses TBCacao quite extensively. Have a look for a real life example.

## Usage

First, include `TBCacao` in your project by either adding it as a Framework or copying all `TBCacao` classes into your project. To initialize `TBCacao` you add the following line to `main.m` before you return:
```objc
[[TBContext sharedContext] initContext];
```
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

- - -

TODO: Describe `TBManualBeanProvider` and `TB_MANUALWIRE`.
