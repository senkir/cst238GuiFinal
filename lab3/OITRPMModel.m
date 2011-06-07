//
//  OITRPMModel.m
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITRPMModel.h"
#import "OITCarController.h"

#define kMinValueRunning       200.0f
@implementation OITRPMModel

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = 0;
        _maxValue = 8000; //values read are 1/1000 this
        _modelType = @"rpm";
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) update {
    [super update];
    
    //delta should change over time
    if (_delta != 0 ) {
        _delta *= 0.6;
    }
}

- (float)maxValue {
    return _maxValue;
}

- (void)setFinalValue:(float)value WithRate:(float)rate {
    if ([[OITCarController sharedOITCarController] isOn] || value <= 0) {
        value = kMinValueRunning;
    }
    [super setFinalValue:value WithRate:rate];
}
@end
