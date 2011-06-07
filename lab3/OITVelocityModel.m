//
//  OITVelocityModel.m
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITVelocityModel.h"


@implementation OITVelocityModel

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = -30.0f; //mph
        _maxValue = 120.0f;
        _modelType = @"speed";
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) update {
    [super update];
    
    //delta should change over time
    if (_delta != 0 ) {
        _delta *= 0.6f;
    }
}

- (void) setValue:(float)value {
    if (_value != value) {
        _value = value;
    }
}
@end