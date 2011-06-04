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


@class OITMeterManager;

@interface OITCarController : NSViewController <OITTimeManagerDelegate> {
@private
    OITTimerManager* _timerManager;
    OITMeterManager* _meterManager;
    NSThread* _thread;
    

}

- (void)startUpdateTimer;
- (void)loadComponents;

//UI Interactions
- (IBAction)gasPedalPressed:(id)sender;
- (IBAction)brakePedalPressed:(id)sender;

@end
