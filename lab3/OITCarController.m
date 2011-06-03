//
//  OITCarController.m
//  lab3
//
//  Created by Travis Churchill on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITCarController.h"


@implementation OITCarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void)dealloc
{
    [_thread release];
    _thread = nil;
    
    [super dealloc];
}


- (void)loadView {
    //TODO: intialize Gauges
    
    //TODO: start listeners
    
    //TODO: turn the car on
    
    //TODO:  apply gas
    
}

- (void)startUpdateTimer {
    [OITLogger logFromSender:[self description] message:@"start update timer"];
    _timerManager = [[OITTimerManager alloc] init];
    [_timerManager startTimerWithDelegate:self];
    _thread = [[NSThread alloc] initWithTarget:_timerManager selector:@selector(buildThread:) object:self];
}


- (void)gasPedalPressed {
    [OITLogger logFromSender:[self description] message:@"gas pedal pressed"];
}

- (void)brakePedalPressed {
    [OITLogger logFromSender:[self description] message:@"brake pedal pressed"];
}

- (void)updateDisplay {
    [OITLogger logFromSender:[self description] message:@"display should update!"];
}
@end
