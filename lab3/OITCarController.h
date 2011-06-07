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

#import "OITMeterManager.h"
#import "OITStyledView.h"

//TODO:  integrate images for clarity of what goes to what

@class AGagueController;

@interface OITCarController : NSViewController <OITTimeManagerDelegate> {
@private
    
    OITTimerManager* _timerManager;
    OITMeterManager* _meterManager;
    NSThread* _thread;
    
    IBOutlet NSButton *_carOnButton;
    IBOutlet NSButton   *_lightsButton;
    IBOutlet OITStyledView *_engineIndicatorView;
    IBOutlet OITStyledView *_lightIndicatorView;
    bool _isOn;
    bool _lightsOn;
    
    AGagueController    *_widgetController;
    
}

@property (nonatomic, readonly) bool isOn;
@property (nonatomic, readonly) bool lightsOn;

- (void)startUpdateTimer;

+ (OITCarController*)sharedOITCarController;

//UI Interactions
- (IBAction)gasPedalPressed:(id)sender;
- (IBAction)brakePedalPressed:(id)sender;

- (IBAction)shiftUp:(id)sender;
- (IBAction)shiftDown:(id)sender;

- (IBAction)toggleCarOn:(id)sender;
- (IBAction)toggleLights:(id)sender;

- (IBAction)resetTrip:(id)sender;
- (IBAction)refillGas:(id)sender;

- (IBAction)toggleGagueMode:(id)sender;

- (void)respondToNotification;
@end
