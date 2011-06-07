//
//  OITLogger.h
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  OITLogger is a helper class to automate logging with a sender attribute.
    In a perfect world i would build this to be compiled out.
 */
@interface OITLogger : NSObject 
+ (void)logFromSender:(NSString*)sender message:(NSString*)message;
+ (void)logFromSender:(NSString*)sender debug:(NSString*)message;
+ (void)logFromSender:(NSString*)sender warn:(NSString*)message;
+ (void)logFromSender:(NSString*)sender error:(NSString*)message;
@end
