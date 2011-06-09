//
//  OITGearBox.m
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "OITCarController.h"

#import "OITGearBox.h"
#import "OITGearModel.h"
#import "OITRPMModel.h"
#import "OITVelocityModel.h"
#import "OITLogger.h"

#define kWheelDiameterCoefficient       250
#define kRPMIncreasePerButtonPress      500.0f
#define kRPMDecreasePerButtonPress      -700.0f
#define KRPMDeltaForUpshift             -3000.0f
#define kRPMDeltaForDownshift           3000.0f
#define kRPMEfficiencyCoefficient       500
#define kRPMRateOfChange                1000

#define kGearRatio1st               1
#define kGearRatio2nd               2
#define kGearRatio3rd               4
#define kGearRatio4th               6
#define kGearRatio5th               10

#define kOilPressureBaseRate        0.2f
#define kTempChangeRate             0.05f

@implementation OITGearBox
@synthesize engine = _engine;
@synthesize speed = _speed;
@synthesize oil = _oil;
@synthesize temp = _temp;

- (id)init
{
    self = [super init];
    if (self) {
        _modelType = @"gearBox";
        _minValue = -1.0f;
        _maxValue = 5.0f;
        _value = 1.0f; //start in 1st for testing purposes
        _gears = [[NSArray arrayWithObjects:[OITGearModel gearWithRatio:kGearRatio1st], 
                   [OITGearModel gearWithRatio:kGearRatio2nd], 
                   [OITGearModel gearWithRatio:kGearRatio3rd], 
                   [OITGearModel gearWithRatio:kGearRatio4th], 
                   [OITGearModel gearWithRatio:kGearRatio5th], 
                   nil] retain];
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
    
    [_oil release];
    _oil = nil;
    
    [_temp release];
    _temp = nil;
    
    [super dealloc];
}

- (void)upshift {
    if (_value < _maxValue) {
    [self incrementValueBy:1.0];
//    [_engine setDelta:KRPMDeltaForUpshift];
    [_engine setFinalValue:[_engine value] + KRPMDeltaForUpshift WithRate:-kRPMRateOfChange];
    }
}

- (void)downshift {
    if (_value > _minValue) {
    [self incrementValueBy:-1.0];
    [_engine setFinalValue:[_engine value] + kRPMDeltaForDownshift WithRate:kRPMRateOfChange];
    }
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
    float toReturn = 0;
    if ([_engine value] > 0 ) {
        
        //this calculation is gibberish
        toReturn = _baseEfficiency * ratio / (rpm / kRPMEfficiencyCoefficient);
    }
    NSString *message = [NSString stringWithFormat:@"efficiencyForEngine: %f", toReturn];
    [OITLogger logFromSender:[self description] message:message];
    return toReturn;
}

- (void)revUp {
    //TODO: gague this by a factor of the gear we're in
//    [_engine setDelta:kRPMIncreasePerButtonPress];
    float finalValue = [_engine value] + kRPMIncreasePerButtonPress;
    float rate = kRPMRateOfChange;
    [_engine setFinalValue:finalValue WithRate:rate];
    [_engine value];
    
}

- (void)revDown {
//    [_engine setDelta:kRPMDecreasePerButtonPress];
    [_engine setFinalValue:[_engine value] + kRPMDecreasePerButtonPress WithRate:-kRPMRateOfChange];
}

- (void)update {
    //speed
    float newSpeed = [_engine value] / kWheelDiameterCoefficient * [self ratioForGear];
//    NSString* logStatement = [NSString stringWithFormat:@"%f * %f = %f", [_engine value] / kWheelDiameterCoefficient , [self ratioForGear], newSpeed];
//    [OITLogger logFromSender:[self description] message:logStatement];
    [_speed setValue:newSpeed];
    
    if ([[OITCarController sharedOITCarController] isOn]) {
        
        // max oil pressure factor of engine rpm
        // 8000rpm = 70psi
        // min 50psi
        // delta =  20psi
        float finalValue = [_engine value] / 8000 * 60 + 20;
        float oilPressureRate = kOilPressureBaseRate * ([_engine value] / 500);
        [_oil setFinalValue:finalValue WithRate:oilPressureRate];
        
        //Temperature
        finalValue = [_engine value] / 8000 * 200;
        float tempChangeRate = kTempChangeRate * ([_engine value] / 8000) * 2;
        [_temp setFinalValue:finalValue WithRate:tempChangeRate];
    }

    
    [super update];
}

@end
