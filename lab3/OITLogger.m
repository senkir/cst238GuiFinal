//
//  OITLogger.m
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITLogger.h"

#define kLogLevel       2
#define kLogError       1
#define kLogWarn        2
#define kLogDebug       3

@implementation OITLogger

+ (void)logFromSender:(NSString *)sender message:(NSString *)message {
    NSLog(@"%@: %@", sender, message);
}

+ (void)logFromSender:(id)sender debug:(NSString *)message {
    if (kLogLevel >= kLogDebug) {
        NSLog(@"%@ %@: %@", @"DEBUG", sender, message);
    }
}

+ (void)logFromSender:(id)sender warn:(NSString *)message {
    if (kLogLevel >= kLogError) {
        NSLog(@"%@ %@: %@", @"WARNING", sender, message);
    }
}

+ (void)logFromSender:(id)sender error:(NSString *)message {
    if (kLogLevel >= kLogError) {
        NSLog(@"%@ %@: %@", @"ERROR", sender, message);
    }
}
@end
