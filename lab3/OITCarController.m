//
//  OITCarController.m
//  lab3
//
//  Created by Travis Churchill on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITCarController.h"
#import "OITMeterManager.h"
#import "OITGearBox.h"

#import "OITSevenSegmentDigitController.h"
#import "OITDigitalNumberSet.h"

#import "OITRPMModel.h"
#import "OITVelocityModel.h"
#import "OITOilModel.h"
#import "OITTemperatureModel.h"
#import "OITChargeModel.h"
#import "OITOdometerModel.h"
#import "OITTripMeterModel.h"

#import "OITDigitalGagueController.h"
#import "OITAnalogGagueController.h"

@implementation OITCarController

@synthesize isOn = _isOn;
@synthesize lightsOn = _lightsOn;

static OITCarController *sharedInstance = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _meterManager = [OITMeterManager sharedOITMeterManager];
        _isOn = FALSE;
        _lightsOn = FALSE;
        
    }
    
    return self;
}

/** Singleton constructor **/
+ (OITCarController*)sharedOITCarController {
    @synchronized(self) {
        if (sharedInstance == nil) {
            [[self alloc] initWithNibName:@"OITCarController" bundle:nil];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (void)release
{
    // do nothing
}

- (id)autorelease
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}

- (void)dealloc
{
    [_meterManager release];
    _meterManager = nil;
    
    [_thread release];
    _thread = nil;
    
    [super dealloc];
}


- (void)loadView {
    [super loadView];
    [OITLogger logFromSender:[self description] message:@"loadView"];
    
    /***** Initial state of indicators *****/
    
    [_engineIndicatorView setBackgroundColor:[NSColor redColor]];
    [_lightIndicatorView setBackgroundColor:[NSColor grayColor]];
    
    NSRect widgetsRect = self.view.frame;
    _widgetController = [[OITDigitalGagueController alloc] initWithFrame:widgetsRect];
//    _widgetController = [[OITAnalogGagueController alloc] initWithFrame:widgetsRect];
    
    [self.view addSubview:_widgetController.view];
    [_meterManager setDelegate:_widgetController];
    [self.view setNeedsDisplay:true];
}


- (void)startUpdateTimer {
    [OITLogger logFromSender:[self description] message:@"start update timer"];
    _timerManager = [[OITTimerManager alloc] init];
    [_timerManager startTimerWithDelegate:self];
    _thread = [[NSThread alloc] initWithTarget:_timerManager selector:@selector(buildThread:) object:self];
}


- (IBAction)gasPedalPressed:(id)sender {
    [OITLogger logFromSender:[self description] message:@"gas pedal pressed"];
    if (_isOn) {
            [_meterManager gasPressed];
    }
}

- (IBAction)brakePedalPressed:(id)sender {
    [OITLogger logFromSender:[self description] message:@"brake pedal pressed"];
    [_meterManager brakePressed];
}

- (void)updateDisplay {
//    [OITLogger logFromSender:[self description] message:@"display should update!"];
    [_meterManager updateMeters];
    if (!_isOn && [[_meterManager rpm] value]) {
        [_meterManager brakePressed];
    }
}

//TODO:  fix this method.  it doesn't do anything yet.
//- (void)keyDown:(NSEvent *)theEvent {
//    [OITLogger logFromSender:[self description] message:@"key down event occured!"];
//}

- (IBAction)shiftUp:(id)sender {
    [[_meterManager gearBox] upshift];
}
- (IBAction)shiftDown:(id)sender {
    [[_meterManager gearBox] downshift];
}
- (IBAction)toggleCarOn:(id)sender {
    if (_isOn) {
        _isOn = false;
        [_carOnButton setTitleWithMnemonic:@"Turn &On"];
        [_engineIndicatorView setBackgroundColor:[NSColor redColor]];
    } else {
        _isOn = true;
        [_carOnButton setTitleWithMnemonic:@"Turn &Off"];
        [_engineIndicatorView setBackgroundColor:[NSColor grayColor]];
        [self gasPedalPressed:nil];
    }
    [_engineIndicatorView setNeedsDisplay:TRUE];
}

- (IBAction)toggleLights:(id)sender {
    if (_lightsOn) {
        _lightsOn = false;
        [_lightsButton setTitleWithMnemonic:@"&Lights On"];
        [_lightIndicatorView setBackgroundColor:[NSColor grayColor]];
    } else {
        _lightsOn = true;
        [_lightsButton setTitleWithMnemonic:@"&Lights Off"];
        [_lightIndicatorView setBackgroundColor:[NSColor yellowColor]];
    }
    [_lightIndicatorView setNeedsDisplay:TRUE];
}
         
 - (void)respondToNotification {
     //do stuff 
 }


- (IBAction)resetTrip:(id)sender {
    [_meterManager resetTrip];
}

- (IBAction)refillGas:(id)sender {
    [_meterManager refillGas];
}

- (IBAction)toggleGagueMode:(id)sender {
    [OITLogger logFromSender:[self description] warn:@"toggleGagueMode activated."];
    AGagueController* controller = nil;
    NSRect widgetsRect = self.view.frame;

    if ([_widgetController isKindOfClass:[OITDigitalGagueController class]]) {
        controller = [[OITAnalogGagueController alloc] initWithFrame:widgetsRect];
    } else {
        controller = [[OITDigitalGagueController alloc] initWithFrame:widgetsRect];
    }
    //get rid of the old view
    if (_widgetController) {
        [_widgetController.view removeFromSuperview];
        [_widgetController release];
    }
    
    //initialize a new one
    _widgetController = controller;
    [self.view addSubview:_widgetController.view];
    [_meterManager setDelegate:_widgetController];
    [self.view setNeedsDisplay:true];
}

@end
