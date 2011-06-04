//
//  AModel.m
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AModel.h"


@implementation AModel

@synthesize value = _value;
@synthesize delta = _delta;
@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = 0;
        _maxValue = 0;
        _value = 0;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)incrementValueBy:(float) value {
    self.value += value;
    if (_value > _maxValue) {
        _value = _maxValue;
    }
    if (_value < _minValue ) {
        _value = _minValue;
    }
}

- (void)incrementDeltaBy:(float) delta {
    _delta += delta;
}

- (void)update {
    [self incrementValueBy:_delta];
}

/**
 *  For display purposes
 */
- (float)percentOfMax {
    return _value / _maxValue;
}
@end
