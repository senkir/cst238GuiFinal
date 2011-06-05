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

#define kYbuffer        10.0

@implementation OITCarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _meterManager = [[OITMeterManager alloc] init];
        [_meterManager setDelegate:self];
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
    //RPM
    _rpm = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:3];
    [_rpm loadView];
    [_rpm setTitle:@"RPM"];
    [self.view addSubview:[_rpm view]];    
    [[_rpm view] setFrame:NSMakeRect(0, self.view.frame.size.height - _rpm.view.frame.size.height - kYbuffer, _rpm.view.frame.size.width, _rpm.view.frame.size.height)];
    
//    _speed = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:3];
//    [_speed setTitle:@"Speed"];
//    [self.view addSubview:[_speed view]];
//    [[_rpm view] setFrame:NSMakeRect(_rpm.view.frame.size.width + _rpm.view.frame.origin.x, self.view.frame.size.height - _rpm.view.frame.size.height - kYbuffer, _speed.view.frame.size.width, _speed.view.frame.size.height)];

}

- (void)startUpdateTimer {
    [OITLogger logFromSender:[self description] message:@"start update timer"];
    _timerManager = [[OITTimerManager alloc] init];
    [_timerManager startTimerWithDelegate:self];
    _thread = [[NSThread alloc] initWithTarget:_timerManager selector:@selector(buildThread:) object:self];
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

-(void)modelDidUpdate:(AModel*)model {
    if ([model isKindOfClass:[OITRPMModel class]]) {
        [_rpm setValue:[model value]/100];
    } else if ([model isKindOfClass:[OITVelocityModel class]]) {
        [_speed setValue:[model value]];
    }
}

@end
