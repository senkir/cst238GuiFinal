//
//  OITCarController.m
//  lab3
//
//  Created by Travis Churchill on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITCarController.h"
#import "OITMeterManager.h"

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
    //TODO: intialize Gauges
    
    //TODO: start listeners
    
    //TODO: turn the car on
    
    //TODO:  apply gas
    [self becomeFirstResponder];
    [self loadComponents];
    
}

- (void)loadComponents {
    [OITLogger logFromSender:[self description] message:@"Load components"];
    
//    OITSevenSegmentDigitController *digit1 = [[OITSevenSegmentDigitController alloc] initWithNibName:@"OITSevenSegmentDigitController" bundle:nil];
//    OITSevenSegmentDigitController *digit2 = [[OITSevenSegmentDigitController alloc] initWithNibName:@"OITSevenSegmentDigitController" bundle:nil];
//    
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

- (void)keyDown:(NSEvent *)theEvent {
    [OITLogger logFromSender:[self description] message:@"key down event occured!"];
}
@end
