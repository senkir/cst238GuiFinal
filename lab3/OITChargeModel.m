//
//  OITChargeModel.m
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITChargeModel.h"
#import "OITCarController.h"

#define kBaseDischargeRate      -0.03f
#define kBaseChargeRate         0.05f
@implementation OITChargeModel

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = 0;
        _maxValue = 100;
        _value = 100;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)update {
    [super update];
    bool isOn = [[OITCarController sharedOITCarController] isOn];
    bool lightsOn = [[OITCarController sharedOITCarController] lightsOn];
    if (isOn ) {
        if (lightsOn) {
            [self setFinalValue:100 WithRate:kBaseChargeRate/2];
        } else {
            [self setFinalValue:100 WithRate:kBaseChargeRate];
        }
    } else {
        if (lightsOn) {
            [self setFinalValue:0 WithRate:kBaseDischargeRate];
        } else {
            [self setFinalValue:0 WithRate:kBaseDischargeRate/20];
        }
    }
}

@end
