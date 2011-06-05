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

#define kYbuffer        10.0
#define kXbuffer        20.0
@implementation OITCarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _meterManager = [[OITMeterManager alloc] init];
        [_meterManager setDelegate:self];
        _isOn = FALSE;
        _lightsOn = FALSE;
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
    [_engineIndicatorView setBackgroundColor:[NSColor redColor]];
    [_lightIndicatorView setBackgroundColor:[NSColor grayColor]];
    //RPM
    _rpm = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:3 AndDecimalPlaceAfterDigit:1];
    [_rpm loadView];
    [_rpm setTitle:@"RPM"];
    [self.view addSubview:[_rpm view]]; 

    _speed = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:3 AndDecimalPlaceAfterDigit:2];
    [_speed loadView];
    [_speed setTitle:@"Speed"];
    [self.view addSubview:[_speed view]];
    
    _fuel = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:3 AndDecimalPlaceAfterDigit:2];
    [_fuel loadView];
    [_fuel setTitle:@"Fuel"];
    [self.view addSubview:[_fuel view]];
    
    _gear = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:1];
    [_gear loadView];
    [_gear setTitle:@"Gear"];
    [self.view addSubview:[_gear view]];
    
    NSDictionary *gagueDictionary = [[NSMutableDictionary alloc] init];
    [gagueDictionary setValue:_rpm forKey:@"RPM"];
    [gagueDictionary setValue:_speed forKey:@"Speed"];
    [gagueDictionary setValue:_fuel forKey:@"Fuel"];
    [gagueDictionary setValue:_gear forKey:@"Gear"];
    
    NSArray* allControllers = [gagueDictionary allValues];
    NSUInteger xOffset = 0;
    for (int i = 0; i < [allControllers count]; i++) {
        NSViewController* controller = [allControllers objectAtIndex:i];
        [[controller view] setFrame:NSMakeRect(xOffset,  
                                               self.view.frame.size.height - controller.view.frame.size.height - kYbuffer, //window height - contrller height
                                               controller.view.frame.size.width, 
                                               controller.view.frame.size.height)];
        xOffset += controller.view.frame.size.width + kXbuffer;
    }
    
//    [[_speed view] setFrame:NSMakeRect(_speed.view.frame.size.width + _speed.view.frame.origin.x, self.view.frame.size.height - _speed.view.frame.size.height - kYbuffer, _speed.view.frame.size.width, _speed.view.frame.size.height)];

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
    if (!_isOn) {
        [_meterManager brakePressed];
    }
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
        [_engineIndicatorView setBackgroundColor:[NSColor redColor]];
    } else {
        _isOn = true;
        [_carOnButton setTitle:@"Turn Off"];
        [_engineIndicatorView setBackgroundColor:[NSColor grayColor]];
        [self gasPedalPressed:nil];
    }
    [_engineIndicatorView setNeedsDisplay:TRUE];
}

- (IBAction)toggleLights:(id)sender {
    if (_lightsOn) {
        _lightsOn = false;
        [_lightsButton setTitle:@"Lights On"];
        [_lightIndicatorView setBackgroundColor:[NSColor grayColor]];
    } else {
        _lightsOn = true;
        [_lightsButton setTitle:@"Lights Off"];
        [_lightIndicatorView setBackgroundColor:[NSColor yellowColor]];
    }
    [_lightIndicatorView setNeedsDisplay:TRUE];
}

-(void)modelDidUpdate:(AModel*)model {
    if ([model isKindOfClass:[OITRPMModel class]]) {
        [_rpm setValue:[model value]/1000];
    } else if ([model isKindOfClass:[OITVelocityModel class]]) {
        [_speed setValue:[model value]];
    } else if ([model isKindOfClass:[OITFuelModel class]]) {
        [_fuel setValue:[model value]];
    } else if ([model isKindOfClass:[OITGearBox class]]) {
        [_gear setValue:[model value]];
    }

}

@end
