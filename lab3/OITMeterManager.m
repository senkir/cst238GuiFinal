//
//  OITMeterManager.m
//  lab3
//
//  Created by Travis Churchill on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITMeterManager.h"

#import "OITRPMModel.h"
#import "OITFuelModel.h"
#import "OITVelocityModel.h"
#import "OITGearBox.h"
#import "OITOilModel.h"
#import "OITTemperatureModel.h"
#import "OITChargeModel.h"

#import "OITCarController.h"
#import "OITLogger.h"

#define kRPMDeltaForNoFuel  -5000

@implementation OITMeterManager

@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        
        /*** This is where the model objects actually get instantiated ***/
        
        _gearBox = [[OITGearBox alloc] init];
        [_gearBox setDelegate:self];
        
        _rpm = [[OITRPMModel alloc] init];
        [_rpm setDelegate:self];
        [_gearBox setEngine:_rpm];
        
        _speed = [[OITVelocityModel alloc] init];
        [_speed setDelegate:self];
        [_gearBox setSpeed:_speed];
        
        _oil = [[OITOilModel alloc] init];
        [_oil setDelegate:self];
        [_gearBox setOil:_oil];
        
        _fuel = [[OITFuelModel alloc] init];
        [_fuel setDelegate:self];
        
        _temp = [[OITTemperatureModel alloc] init];
        [_temp setDelegate:self];
        [_gearBox setTemp:_temp];
        
        _charge = [[OITChargeModel alloc] init];
        [_charge setDelegate:self];
         
        //  shorthand reference point
        _allMeters = [[NSArray arrayWithObjects:_rpm, _gearBox, _speed, _fuel, _oil, _temp, _charge, nil] retain];
    }
    return self;
}

- (void)dealloc {
    [_allMeters release];
    _allMeters = nil;
    
    [_rpm release];
    _rpm = nil;
    [_gearBox release];
    _gearBox = nil;
    [_speed release];
    _speed = nil;
    [_fuel  release];
    _fuel = nil;
    [_oil release];
    _oil = nil;
    [_temp release];
    _temp = nil;
    [_charge release];
    _charge = nil;
    
    [super dealloc];
}

- (void)updateMeters {
    for (AModel *model in _allMeters) {
        [model update];
        NSString* modelMessage = [NSString stringWithFormat:@"%@ has a value of %f",[model description] , [model value]];
        [OITLogger logFromSender:[self description] message:modelMessage];
    }
}

- (void)gasPressed {
    [_gearBox revUp];
}

- (void)brakePressed {
    [_gearBox revDown];
}

- (void)fuelIsEmpty:(id)sender {
    [OITLogger logFromSender:[self description] message:@"Fuel is Empty!"];
    [_rpm setDelta:kRPMDeltaForNoFuel];
}

- (float)fuelConsumptionRate {
    float rate = 0;
    if ([[OITCarController sharedOITCarController] isOn]) {
        rate = [_gearBox efficiencyForEngine] / 400;
    }
    if (rate != 0 ) {
        NSString* message = [NSString stringWithFormat:@"rate is %f", rate];
        [OITLogger logFromSender:[self description] message:message];
    }
    return rate;
}

- (void)modelDidUpdate:(AModel*)sender {
    [_delegate modelDidUpdate:sender];
}

- (OITGearBox*)gearBox {
    return _gearBox;
}


@end
