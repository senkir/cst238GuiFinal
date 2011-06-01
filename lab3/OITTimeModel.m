//
//  OITTimeModel.m
//  lab2DasClock
//
//  Created by Travis Churchill on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITTimeModel.h"


@implementation OITTimeModel

@synthesize referenceDate = _referenceDate;
@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        //get the datetime right now
        _referenceDate = [NSDate date];

    }
    
    return self;
}

- (void)dealloc
{
    [_secondTimer invalidate];
    [_secondTimer release];
    _secondTimer = nil;
    [_minuteTimer invalidate];
    [_minuteTimer release];
    _minuteTimer = nil;
    [_delegate release];
    _delegate = nil;
    [super dealloc];
}

- (void)setDelegate:(id<OITTimeModelDelegate>)delegate {
    if (delegate != _delegate) {
        [_delegate release];
        _delegate = [delegate retain];
        //rig a timer for the delegate
        _secondTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondsDidChange) userInfo:nil repeats:true];
        _minuteTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(minutesDidChange) userInfo:nil repeats:true];
    }
}

- (void)secondsDidChange {
    _referenceDate = [NSDate date];
    if ([_delegate respondsToSelector:@selector(secondsShouldUpdate:)]) {
        [_delegate secondsShouldUpdate:_referenceDate];
    }
}

- (void)minutesDidChange {
    _referenceDate = [NSDate date];
    if ([_delegate respondsToSelector:@selector(minutesShouldUpdate:)]) {
        [_delegate minutesShouldUpdate:_referenceDate];
    }
}
@end
