//
//  OITFuelModel.m
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITFuelModel.h"


@implementation OITFuelModel

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = 0.0;
        _maxValue = 13.0; //gallons
        _value = _maxValue;
        _modelType = @"fuel";
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)refill {
    _value = _maxValue;
}

- (void)incrementValueBy:(float)value {
    [super incrementValueBy:value];
    if (_value == 0 && _delegate) {
        if ([(NSObject*)_delegate respondsToSelector:@selector(fuelIsEmpty:)]) {
            [(id<FuelModelDelegate>)_delegate fuelIsEmpty:self];
        }
    }
}

- (bool)isEmpty {
    return _value > 0 ? true : false;
}

- (void)update {
    [super update];
    if ([(NSObject*)_delegate respondsToSelector:@selector(fuelConsumptionRate)]) {
        [self setDelta:-[(id<FuelModelDelegate>)_delegate fuelConsumptionRate]];
    }
}
@end
