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

#import "OITOdometerModel.h"
#import "OITTripMeterModel.h"

#import "OITCarController.h"
#import "OITLogger.h"

#define kRPMDeltaForNoFuel      -5000
#define kMilesPerTenthOfASecond (1.0f/3600.0f)

@implementation OITMeterManager

static OITMeterManager *sharedInstance = nil;

@synthesize delegate = _delegate;
@synthesize rpm = _rpm;

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
        
        _miles = [[OITOdometerModel alloc] init];
        [_miles setDelegate:self];
        
        _trip = [[OITTripMeterModel alloc] init];
        [_trip setDelegate:self];
         
        //  shorthand reference point
        _allMeters = [[NSArray arrayWithObjects:_rpm, _gearBox, _speed, _fuel, _oil, _temp, _charge, _trip, _miles, nil] retain];
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
    [_trip release];
    _trip = nil;
    
    [super dealloc];
}

/** Singleton constructor **/
+ (OITMeterManager*)sharedOITMeterManager {
    @synchronized(self) {
        if (sharedInstance == nil) {
            [[self alloc] init];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (void)release
{
    // do nothing
}

- (id)autorelease
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}

- (void)updateMeters {
    for (AModel *model in _allMeters) {
        [model update];
        NSString* modelMessage = [NSString stringWithFormat:@"%@ has a value of %f",[model description] , [model value]];
        [OITLogger logFromSender:[self description] debug:modelMessage];
    }
}

- (void)gasPressed {
    [_gearBox revUp];
}

- (void)brakePressed {
    [_gearBox revDown];
}

- (void)fuelIsEmpty:(id)sender {
    [OITLogger logFromSender:[self description] warn:@"Fuel is Empty!"];
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

- (void)resetTrip {
    [_trip reset];
}

- (void)refillGas {
    [_fuel refill];
}

- (float) milesTraveled:(OITOdometerModel*)model {
    float toReturn = [_speed value] * kMilesPerTenthOfASecond;
    NSString* message = [NSString stringWithFormat:@"%f mph.  milesTraveled = %f", [_speed value], toReturn];
    [OITLogger logFromSender:[self description] debug:message];
    return toReturn;
}

@end
