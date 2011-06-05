//
//  OITOilModel.m
//  lab3
//
//  Created by Travis Churchill on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITOilModel.h"


@implementation OITOilModel

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = 0;
        _maxValue = 100;
        _value = 50; //psi?
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
