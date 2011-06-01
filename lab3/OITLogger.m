//
//  OITLogger.m
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITLogger.h"


@implementation OITLogger

+ (void)log:(NSString *)sender message:(NSString *)message {
    NSLog(@"%@: %@", sender, message);
}
@end
