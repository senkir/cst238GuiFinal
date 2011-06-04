//
//  OITRPMModel.m
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITRPMModel.h"


@implementation OITRPMModel

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = 0;
        _maxValue = 8000; //values read are 1/1000 this
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
