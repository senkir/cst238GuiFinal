//
//  OITMeterManager.h
//  lab3
//
//  Created by Travis Churchill on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AModel.h"
#import "OITFuelModel.h"
#import "OITOdometerModel.h"

@class OITFuelModel;
@class OITVelocityModel;
@class OITRPMModel;
@class OITGearBox;
@class OITOilModel;
@class OITTemperatureModel;
@class OITChargeModel;
@class OITTripMeterModel;

@protocol OITMeterManagerDelegate <NSObject>

-(void)modelDidUpdate:(AModel*)model;

@end

@interface OITMeterManager : NSObject <FuelModelDelegate> {
@private
    OITFuelModel        *_fuel;
    OITVelocityModel    *_speed;
    OITRPMModel         *_rpm;
    OITGearBox          *_gearBox;
    OITOilModel         *_oil;
    OITTemperatureModel *_temp;
    OITChargeModel      *_charge;
    OITOdometerModel    *_miles;
    OITTripMeterModel   *_trip;
    
    NSArray             *_allMeters;
    /*
     gear   x
     temp   x
     fuel   x
     rpm    x
     oil    x
     charge x
     car    x
     velocity   x
     odometer   x
     trip   x
     */
    
    id<OITMeterManagerDelegate> _delegate;
}

@property (nonatomic, retain) id<OITMeterManagerDelegate> delegate;

+ (OITMeterManager*)sharedOITMeterManager;

- (void)updateMeters;

- (void)gasPressed;
- (void)brakePressed;

- (void)resetTrip;
- (void)refillGas;

- (OITGearBox*)gearBox;
@end
