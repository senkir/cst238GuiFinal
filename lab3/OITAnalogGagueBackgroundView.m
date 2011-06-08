//
//  OITAnalogGague.m
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITAnalogGagueBackgroundView.h"


@implementation OITAnalogGagueBackgroundView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSBezierPath* path = [NSBezierPath bezierPathWithOvalInRect:self.frame];
    [[NSColor whiteColor] set];
    [path fill];
    [[NSColor blackColor] set];
    [path stroke];
}

@end
