//
//  OITGearBox.m
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITGearBox.h"
#import "OITGearModel.h"

@implementation OITGearBox

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = -1;
        _maxValue = 5;
        _gears = [NSArray arrayWithObjects:[OITGearModel gearWithRatio:1], [OITGearModel gearWithRatio:2], [OITGearModel gearWithRatio:4], [OITGearModel gearWithRatio:6], [OITGearModel gearWithRatio:10], nil];
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)upshift {
    [self incrementValueBy:1.0];
}

- (void)downshift {
    [self incrementValueBy:-1.0];
}

- (float)ratioForGear {
    if (_value >= 1) {
        return [[_gears objectAtIndex:round(_value - 1)] ratio];
    }
    return _value;
}
@end
