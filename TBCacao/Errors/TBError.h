/**
 * This is the subclass of NSError encoding all errors for TBCacao.
 *
 * @author Tae Won Ha
 * @since 0.0.1
 *
 * Copyright 2011 Tae Won Ha, See LICENSE for details.
 * 
 */

#import <Foundation/Foundation.h>


#define TBErrorDomain           @"com.hataewon.TBCacao.ErrorDomain"
#define TBErrorKeyMessage       @"message"
#define TBErrorCodeDefault      0


@interface TBError : NSError {}


/**
 * This is the message of the error.
 * @since 0.0.1
 */
@property (readonly, nonatomic) NSString *message;


/**
 * A class method to create an error with a message.
 * @since 0.0.1
 */
+ (id)errorWithMessage:(NSString *)message;


@end
