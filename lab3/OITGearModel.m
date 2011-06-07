//
//  OITGearModel.m
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITGearModel.h"

@interface OITGearModel (private)
- (void)setRatio:(float)ratio;
@end

@implementation OITGearModel

/**
 *  It's common for these static methods to return autoreleased objects.
 */
+ (OITGearModel*)gearWithRatio:(float)ratio {
    OITGearModel* gear = [[[OITGearModel alloc] init] autorelease];
    [gear setRatio:ratio];
    return gear;
}

- (id)init
{
    self = [super init];
    if (self) {
        _modelType = @"gear";
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)setRatio:(float)ratio {
    _ratio = ratio;
}

- (float)ratio {
    return _ratio;
}

@end
