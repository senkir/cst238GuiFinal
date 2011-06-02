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

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
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
}

- (void)decrementValueBy:(float) value {
    _value -= value;
    if (_value < 0 ) {
        _value = 0;
    }
}

- (void)incrementDeltaBy:(float) delta {
    
}

- (void)decrementDeltaBy:(float) delta {
    
}

- (float)percentOfMax {
    return _value / _maxValue;
}
@end
