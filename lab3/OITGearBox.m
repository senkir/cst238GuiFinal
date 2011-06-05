//
//  OITGearBox.m
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITGearBox.h"
#import "OITGearModel.h"
#import "OITRPMModel.h"
#import "OITVelocityModel.h"
#import "OITLogger.h"

#define kWheelDiameterCoefficient       250
#define kRPMIncreasePerButtonPress      500.0f
#define kRPMDecreasePerButtonPress      -700.0f

@implementation OITGearBox
@synthesize engine = _engine;
@synthesize speed = _speed;

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = -1.0f;
        _maxValue = 5.0f;
        _value = 1.0f; //start in 1st for testing purposes
        _gears = [[NSArray arrayWithObjects:[OITGearModel gearWithRatio:1], [OITGearModel gearWithRatio:2], [OITGearModel gearWithRatio:4], [OITGearModel gearWithRatio:6], [OITGearModel gearWithRatio:10], nil] retain];
        _efficiency = 
        _baseEfficiency = 25; //miles per gallon
    }
    
    return self;
}

- (void)dealloc {
    [_gears release];
    _gears = nil;
    
    [_speed release];
    _speed = nil;
    
    [_engine release];
    _engine = nil;
    
    [super dealloc];
}

- (void)upshift {
    [self incrementValueBy:1.0];
}

- (void)downshift {
    [self incrementValueBy:-1.0];
}

- (float)ratioForGear {
    if (_value >= 1) {
        return [[_gears objectAtIndex:round(_value - 1)] ratio];
    }
    return _value; //NOTE:  this might lead to unexpected results when in Reverse
}

- (float)efficiencyForEngine {
    float ratio = [self ratioForGear];
    float rpm = [_engine value];
    float result = [_engine value] > 0 ? _baseEfficiency * ratio / (rpm / [_engine maxValue] ) : 0; //this isn't quite right
    return result;
}

- (void)revUp {
    //TODO: gague this by a factor of the gear we're in
    [_engine setDelta:kRPMIncreasePerButtonPress];
}

- (void)revDown {
    [_engine setDelta:kRPMDecreasePerButtonPress];
}

- (void)update {
    float newSpeed = [_engine value] / kWheelDiameterCoefficient * [self ratioForGear];
    NSString* logStatement = [NSString stringWithFormat:@"%f * %f = %f", [_engine value] / kWheelDiameterCoefficient , [self ratioForGear], newSpeed];
    [OITLogger logFromSender:[self description] message:logStatement];
    [_speed setValue:newSpeed];
}

@end
