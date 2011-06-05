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

@class OITFuelModel;
@class OITVelocityModel;
@class OITRPMModel;
@class OITGearBox;
@class OITOilModel;

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
    NSArray             *_allMeters;
    /*
     gear
     temp
     fuel
     rpm
     oil
     charge
     car
     velocity
     odometer
     trip
     */
    
    id<OITMeterManagerDelegate> _delegate;
}

@property (nonatomic, retain) id<OITMeterManagerDelegate> delegate;
- (void)updateMeters;
- (void)gasPressed;
- (void)brakePressed;
- (OITGearBox*)gearBox;
@end
