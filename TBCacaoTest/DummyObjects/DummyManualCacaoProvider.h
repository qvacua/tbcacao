#import <Foundation/Foundation.h>


@class DummyPlainObject, DummyPlainSubObject, DummyManualCacao;


@interface DummyManualCacaoProvider : NSObject {
@private
    DummyPlainObject *object;
    DummyPlainSubObject *subObject;
    DummyManualCacao *manualCacao;
}


@property (readonly) DummyPlainObject *object;
@property (readonly) DummyPlainSubObject *subObject;
@property (readonly) DummyManualCacao *manualCacao;


@end
