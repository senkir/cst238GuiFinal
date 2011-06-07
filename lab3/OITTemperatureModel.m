//
//  OITTemperatureModel.m
//  lab3
//
//  Created by Travis Churchill on 6/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITTemperatureModel.h"
#import "OITCarController.h"

#define kBaseRateOfCooling      -0.005f

@implementation OITTemperatureModel

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = 68.0;
        _maxValue = 200.0;
        _value = 58.8;
        _modelType = @"temp";
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)update {
    if (![[OITCarController sharedOITCarController] isOn]) {
        [self setFinalValue:_minValue WithRate:kBaseRateOfCooling];
    }
    [super update];
}
@end
