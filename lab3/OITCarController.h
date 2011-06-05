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

#import "OITDigitalReadoutController.h"

@class OITMeterManager;

@interface OITCarController : NSViewController <OITTimeManagerDelegate> {
@private
    OITTimerManager* _timerManager;
    OITMeterManager* _meterManager;
    NSThread* _thread;
    
    IBOutlet NSButton *_carOnButton;
    IBOutlet NSButton   *_lightsButton;
    bool _isOn;
    bool _lightsOn;
    
    OITDigitalReadoutController*     _digitalReadout1;
}

- (void)startUpdateTimer;
- (void)loadComponents;

//UI Interactions
- (IBAction)gasPedalPressed:(id)sender;
- (IBAction)brakePedalPressed:(id)sender;
- (IBAction)shiftUp:(id)sender;
- (IBAction)shiftDown:(id)sender;
- (IBAction)toggleCarOn:(id)sender;
- (IBAction)toggleLights:(id)sender;
@end
