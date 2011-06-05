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

@interface OITMeterManager : NSObject <FuelModelDelegate> {
@private
    OITFuelModel        *_fuel;
    OITVelocityModel    *_speed;
    OITRPMModel         *_rpm;
    OITGearBox          *_gearBox;
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
}
- (void)updateMeters;
- (void)gasPressed;
- (void)brakePressed;
- (OITGearBox*)gearBox;
@end
