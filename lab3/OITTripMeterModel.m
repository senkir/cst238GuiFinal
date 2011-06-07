//
//  OITTripMeterModel.m
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITTripMeterModel.h"


@implementation OITTripMeterModel

- (id)init
{
    self = [super init];
    if (self) {
        _modelType = @"trip";
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)reset {
    _value = _minValue;
}

@end
