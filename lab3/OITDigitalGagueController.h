//
//  OITDigitalGagueController.h
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AGagueController.h"

@class OITDigitalReadoutController;

@interface OITDigitalGagueController : AGagueController {
@private
    OITDigitalReadoutController*     _rpm;
    OITDigitalReadoutController*    _speed;
    OITDigitalReadoutController*    _gear;
    OITDigitalReadoutController*    _fuel;
    OITDigitalReadoutController*    _oil;
    OITDigitalReadoutController*    _temp;
    OITDigitalReadoutController*    _charge;
    
    OITDigitalReadoutController*    _odometer;
    OITDigitalReadoutController*    _trip;
    
}

@end
