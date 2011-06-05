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

@implementation OITCarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _meterManager = [[OITMeterManager alloc] init];
    }
    
    return self;
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
    [self loadComponents];
    //TODO: intialize Gauges
//    [_digitalReadout1 loadView];
    //TODO: start listeners
    
    //TODO: turn the car on
    
    //TODO:  apply gas
//    [self becomeFirstResponder];
    
}

- (void)loadComponents {
    [OITLogger logFromSender:[self description] message:@"Load components"];
    _digitalReadout1 = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:3];
    [self.view addSubview:[_digitalReadout1 view]];
//    OITSevenSegmentDigitController *digit1 = [[OITSevenSegmentDigitController alloc] initWithNibName:@"OITSevenSegmentDigitController" bundle:nil];
//    OITSevenSegmentDigitController *digit2 = [[OITSevenSegmentDigitController alloc] initWithNibName:@"OITSevenSegmentDigitController" bundle:nil];
//    
//    [[_digitalReadout1 view] setFrame:NSMakeRect(0, 0, 200, 200)];
//    [[_digitalReadout1 view] setNeedsDisplay:true];
//    [self.view setNeedsDisplay:true];
}

- (void)startUpdateTimer {
    [OITLogger logFromSender:[self description] message:@"start update timer"];
    _timerManager = [[OITTimerManager alloc] init];
    [_timerManager startTimerWithDelegate:self];
    _thread = [[NSThread alloc] initWithTarget:_timerManager selector:@selector(buildThread:) object:self];
    [self becomeFirstResponder];
}


- (IBAction)gasPedalPressed:(id)sender {
    [OITLogger logFromSender:[self description] message:@"gas pedal pressed"];
    [_meterManager gasPressed];
    
}

- (IBAction)brakePedalPressed:(id)sender {
    [OITLogger logFromSender:[self description] message:@"brake pedal pressed"];
    [_meterManager brakePressed];
}

- (void)updateDisplay {
//    [OITLogger logFromSender:[self description] message:@"display should update!"];
    [_meterManager updateMeters];
}

//TODO:  fix this method.  it doesn't do anything yet.
- (void)keyDown:(NSEvent *)theEvent {
    [OITLogger logFromSender:[self description] message:@"key down event occured!"];
}

- (IBAction)shiftUp:(id)sender {
    [[_meterManager gearBox] upshift];
}
- (IBAction)shiftDown:(id)sender {
    [[_meterManager gearBox] downshift];
}
- (IBAction)toggleCarOn:(id)sender {
    if (_isOn) {
        _isOn = false;
        [_carOnButton setTitle:@"Turn On"];
    } else {
        _isOn = true;
        [_carOnButton setTitle:@"Turn Off"];
    }
}
- (IBAction)toggleLights:(id)sender {
    if (_lightsOn) {
        _lightsOn = false;
        [_lightsButton setTitle:@"Lights On"];
    } else {
        _lightsOn = true;
        [_lightsButton setTitle:@"Lights Off"];
    }}
@end
