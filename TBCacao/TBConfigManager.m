/*
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 *
 */

#import "NSObject+TBCacao.h"

#import "TBConfigManager.h"
#import "TBLog.h"
#import "TBError.h"
#import "TBConfigException.h"


@implementation TBConfigManager


@synthesize configFileName;

@synthesize configManualCacaoProviders;
@synthesize configManualCacaos;
@synthesize configCacaos;


- (NSDictionary *)configDictionaryWithPossibleError:(TBError **)error {
    NSString *errorDesc;
    NSString *configPath = [[NSBundle mainBundle] pathForResource:[configFileName stringByDeletingPathExtension] ofType:@"plist"];
    NSData *plistXml = [[NSFileManager defaultManager] contentsAtPath:configPath];
    NSPropertyListFormat format;
    NSDictionary *configDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXml 
                                                                                mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                                                          format:&format
                                                                                errorDescription:&errorDesc];
    
    if (configDict == nil) {
        NSString *errorMsg = [NSString stringWithFormat:@"An error occurred during processing the config file cacao.plist: %@", errorDesc];
        
        log4Fatal(@"%@", errorMsg);
        *error = [TBError errorWithMessage:errorMsg];
    }
    
    return configDict;
}

- (BOOL)checkConfigBuild:(NSDictionary *)configDict error:(TBError **)error {
    NSNumber *configBuild = [configDict objectForKey:@"build"];
    
    if ([configBuild intValue] != 1) {
        NSString *errorMsg = [NSString stringWithFormat:
                              @"The build number (%@) of cacao.plist is not compatible with this version of TBCacao with build number %@.",
                              configBuild, @"1"];
        
        log4Fatal(@"%@", errorMsg);
        *error = [TBError errorWithMessage:errorMsg];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)configAlreadyRead {
    return (self.configCacaos && self.configManualCacaos && self.configManualCacaoProviders);
}


- (BOOL)readConfig {
    
    if ([self configAlreadyRead]) {
        log4Info(@"Config already read.");
        return YES;
    }
    
    if (! self.configFileName) {
        @throw [TBConfigException exceptionAbsentConfigFileNameWithReason:@"No config file name given."];
    }
    
    TBError *error = nil;
    NSDictionary *configDict = [self configDictionaryWithPossibleError:&error];
    
    if (error) {
        @throw [TBConfigException exceptionParsingConfigFileWithReason:error.message];
    }
    
    if (! [self checkConfigBuild:configDict error:&error]) {
        @throw [TBConfigException exceptionBuildNumberWithReason:error.message];
    }
    
    configManualCacaoProviders = [[NSArray allocWithZone:nil] initWithArray:[configDict objectForKey:@"manual-cacao-provider"]];
    configManualCacaos = [[NSArray allocWithZone:nil] initWithArray:[configDict objectForKey:@"manual-cacao"]];
    configCacaos = [[NSArray allocWithZone:nil] initWithArray:[configDict objectForKey:@"cacao"]];
    
    return YES;
}

- (BOOL)hasClass:(Class)clazz {
    
    if (! [self configAlreadyRead]) {
        log4Warn(@"Config is not read yet.");
        return NO;
    }
    
    for (NSDictionary *config in [self configCacaos]) {
        NSString *cacaoClass = [config objectForKey:@"class"];
        
        if ([cacaoClass isEqualToString:[clazz classAsString]]) {
            return YES;
        }
    }
    
    for (NSDictionary *config in [self configManualCacaos]) {
        NSString *manualCacaoClass = [config objectForKey:@"class"];
        
        if ([manualCacaoClass isEqualToString:[clazz classAsString]]) {
            return YES;
        }
    }
    
    return NO;
}

- (id)init {
    if ((self = [super init])) {
        configFileName = [[NSString allocWithZone:nil] initWithString:TBCacaoConfigFileNameDefault];
    }
    
    return self;
}

- (id)initWithConfigFileName:(NSString *)filename {
    if ((self = [super init])) {
        configFileName = [filename copyWithZone:nil];
    }

    return self;
}

- (void)dealloc {
    [configFileName release];
    
    [configManualCacaoProviders release];
    [configManualCacaos release];
    [configCacaos release];
    
    [super dealloc];
}

@end
