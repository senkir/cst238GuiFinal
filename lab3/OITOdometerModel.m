//
//  OITOdometerModel.m
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITOdometerModel.h"
#import "OITLogger.h"

@implementation OITOdometerModel

- (id)init
{
    self = [super init];
    if (self) {
        _minValue = 0;
        _maxValue = 999999;
        _value = 0;
        _modelType = @"miles";
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)update {
    if ([(id<NSObject>)_delegate respondsToSelector:@selector(milesTraveled:)]) {
        float miles = [(id<OITOdometerDelegate>)_delegate milesTraveled:self];
        if (miles > 0) {
            NSString* message = [NSString stringWithFormat:@"increase by %f miles.  Final value is %f", miles, [self value] + miles];
            [OITLogger logFromSender:[self description] message:message];
        }
        [self incrementValueBy:miles];
    }
    [super update];
}
@end
