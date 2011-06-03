//
//  OITFuelModel.m
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITFuelModel.h"


@implementation OITFuelModel

@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        _maxValue = 13.0; //gallons
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

- (void)decrementBy:(float)value {
    [super decrementValueBy:value];
    if (_value == 0 && _delegate) {
        [_delegate fuelIsEmpty:self];
    }
}
@end
