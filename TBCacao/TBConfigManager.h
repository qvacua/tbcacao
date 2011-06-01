/**
 * This class is responsible for reading the config plist file. After having read the config file,
 * there are three properties available which contains the content of the config.
 *
 * @author Tae Won Ha
 * @since 0.0.1
 */

#import <Foundation/Foundation.h>


#define TBCacaoConfigFileNameDefault @"cacao.plist"


@class TBError;


@interface TBConfigManager : NSObject {
@private
    NSString *configFileName;
    
    NSArray *configManualCacaoProviders;
    NSArray *configManualCacaos;
    NSArray *configCacaos;
}

/**
 * The name of the config file.
 * The file is read using [[NSBundle mainBundle] pathForResource:FILE_NAME_WITHOUT_EXTENSION ofType:"plist"] method.
 * The default value of this property is: cacao.plist
 * To load a differently named config file, just set this property.
 * @since 0.0.1
 */
@property (copy) NSString *configFileName;

/**
 * After having called readConfigWithPossibleError:, this property will be the array of config dictionary of each cacao.
 * @since 0.0.1
 */
@property (readonly) NSArray *configCacaos;

/**
 * After having called readConfigWithPossibleError:, this property will be the array of config dictionary of each 
 * manual cacao
 * @since 0.0.1
 */
@property (readonly) NSArray *configManualCacaos;

/**
 * After having called readConfigWithPossibleError:, this property will be the array of config dictionary of each
 * subclasses of ManualCacaoProvider
 * @since 0.0.1
 */
@property (readonly) NSArray *configManualCacaoProviders;

/**
 * Reads the config file. This method is NOT called by the init method.
 * @since 0.0.1
 */
- (BOOL)readConfigWithPossibleError:(TBError **)error;

/**
 * Inits the config manager with the given file name.
 * @since 0.0.1
 */
- (id)initWithConfigFileName:(NSString *)filename;


@end
