//
//  OITFuelModel.m
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITFuelModel.h"


@implementation OITFuelModel

@synthesize fuel     = _fuel;
@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        _maxFuel = [[NSNumber numberWithFloat:13.0] retain];;
    }
    
    return self;
}

- (void)dealloc
{
    [_maxFuel release];
    _maxFuel = nil;
    [_fuel release];
    _fuel = nil;
    [super dealloc];
}

- (void)refill:(NSNumber*)fuel {
    
}
- (void)decrement {
    
}
@end
