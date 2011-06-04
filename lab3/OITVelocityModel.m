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
        _minValue = -30.0; //mph
        _maxValue = 120;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end