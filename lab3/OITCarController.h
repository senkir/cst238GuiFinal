//
//  OITCarController.h
//  lab3
//
//  Created by Travis Churchill on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OITTimerManager.h"
#import "OITLogger.h"

@interface OITCarController : NSViewController <OITTimeManagerDelegate> {
@private
    OITTimerManager* _timerManager;
    NSThread* _thread;
}

- (void)startUpdateTimer;

//UI Interactions
- (void)gasPedalPressed;
- (void)brakePedalPressed;

@end
