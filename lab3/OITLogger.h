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
 */
@interface OITLogger : NSObject 
+ (void)logFromSender:(NSString*)sender message:(NSString*)message;
@end
