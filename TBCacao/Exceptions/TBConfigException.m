/**
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import "TBConfigException.h"


@implementation TBConfigException


+ (TBConfigException *)exceptionBuildNumberWithReason:(NSString *)reason {
    return [[[TBConfigException allocWithZone:nil] initWithName:TBConfigBuildNumberIncompatibleException
                                                         reason:reason
                                                       userInfo:nil] autorelease];
}

+ (TBConfigException *)exceptionParsingConfigFileWithReason:(NSString *)reason {
    return [[[TBConfigException allocWithZone:nil] initWithName:TBConfigConfigFileBadlyFormattedException
                                                         reason:reason 
                                                       userInfo:nil] autorelease];
}

+ (TBConfigException *)exceptionAbsentConfigManagerWithReason:(NSString *)reason {
    return [[[TBConfigException allocWithZone:nil] initWithName:TBConfigConfigManagerAbsentException 
                                                         reason:reason
                                                       userInfo:nil] autorelease];
}

+ (TBConfigException *)exceptionAbsentConfigFileNameWithReason:(NSString *)reason {
    return [[[TBConfigException allocWithZone:nil] initWithName:TBConfigBuildNumberIncompatibleException 
                                                         reason:reason 
                                                       userInfo:nil] autorelease];
}


@end
