#import <Foundation/Foundation.h>

#import "TBManualCacaoProvider.h"

@class DummyPlainObject, DummyPlainSubObject, DummyManualCacao;


@interface DummyManualCacaoProvider : TBManualCacaoProvider {
@private
    DummyPlainObject *object;
    DummyPlainSubObject *subObject;
    DummyManualCacao *manualCacao;
}


@property (readonly) DummyPlainObject *object;
@property (readonly) DummyPlainSubObject *subObject;
@property (readonly) DummyManualCacao *manualCacao;


@end
