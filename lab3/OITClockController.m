//
//  OITClockController.m
//  lab2DasClock
//
//  Created by Travis Churchill on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITClockController.h"


@implementation OITClockController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)updateTime {
    NSLog(@"OITClockController: updateTime: Default action does nothing");
}


- (void)initializeTime {
    NSLog(@"Root interface does nothing");
}

@end
