/**
 * Exception thrown when configuration related stuff goes wrong.
 *
 * @author Tae Won Ha
 * @since 0.0.1
 *
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import <Foundation/Foundation.h>
#import "TBException.h"


#define TBConfigConfigFileNameAbsentException     @"TBConfigConfigFileNameAbsentException"
#define TBConfigBuildNumberIncompatibleException  @"TBConfigBuildNumberIncompatibleException"
#define TBConfigConfigFileBadlyFormattedException @"TBConfigConfigFileBadlyFormattedException"
#define TBConfigConfigManagerAbsentException      @"TBConfigConfigManagerAbsentException"


@interface TBConfigException : TBException {}

/**
 * Class method which returns a TBConfigException object with name for wrong build number with a given reason. The userinfo dictionary will be nil.
 * @since 0.0.1
 */
+ (TBConfigException *)exceptionBuildNumberWithReason:(NSString *)reason;

/**
 * Class method which returns a TBConfigException object for errors occurred during parsing the config file with a given reason. The userinfo dictionary will be nil.
 * @since 0.0.1
 */
+ (TBConfigException *)exceptionParsingConfigFileWithReason:(NSString *)reason;

/**
 * Class method which returns a TBConfigException object for absent TBConfigManager with a given reason. The userinfo dictionary will be nil.
 * @since 0.0.1
 */
+ (TBConfigException *)exceptionAbsentConfigManagerWithReason:(NSString *)reason;

/**
 * Class method which returns a TBConfigException object for absent config file name with a given reason. The userinfo dictionary will be nil.
 * @since 0.0.1
 */
+ (TBConfigException *)exceptionAbsentConfigFileNameWithReason:(NSString *)reason;


@end
