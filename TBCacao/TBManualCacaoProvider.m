#import "TBManualCacaoProvider.h"
#import "TBLog.h"


@implementation TBManualCacaoProvider


- (id)init {
    log4Warn(@"TBManualCacaoProvider cannot be instantiated. To use it, please subclass it. Please release me...");
    
    return (self = [super init]);
}


@end
