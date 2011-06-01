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

- (void)incrementBy:(float) value {
    self.value += value;
    if (_value > _maxValue) {
        _value = _maxValue;
    }
}

- (void)decrementBy:(float) value {
    _value -= value;
    if (_value < 0 ) {
        _value = 0;
    }
}

- (float)percentOfMax {
    return _value / _maxValue;
}
@end
