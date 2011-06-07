//
//  OITGearBox.h
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AModel.h"

@class OITRPMModel;
@class OITVelocityModel;
@class OITOilModel;

@interface OITGearBox : AModel {
@private
    NSArray             *_gears;
    OITRPMModel         *_engine;
    OITVelocityModel    *_speed;
    OITOilModel         *_oil;
    float               _baseEfficiency;
    float               _efficiency;
}
@property (nonatomic, retain) OITRPMModel *engine;
@property (nonatomic, retain) OITVelocityModel *speed;
@property (nonatomic, retain) OITOilModel   *oil;
- (void)upshift;
- (void)downshift;
- (void)revUp;
- (void)revDown;
- (float)efficiencyForEngine;
@end
