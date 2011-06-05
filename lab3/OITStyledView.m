//
//  OITStyledView.m
//  lab3
//
//  Created by Travis Churchill on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITStyledView.h"


@implementation OITStyledView

@synthesize backgroundColor = _backgroundColor;

static CGColorRef CGColorCreateFromNSColor (CGColorSpaceRef colorSpace, NSColor *color)
{
    NSColor *deviceColor = [color colorUsingColorSpaceName: NSDeviceRGBColorSpace];
    
    CGFloat components[4];
    [deviceColor getRed: &components[0] green: &components[1] blue: &components[2] alpha: &components[3]];
    
	return CGColorCreate (colorSpace, components);
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundColor = [NSColor blueColor];
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Fill in background Color
    CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreateFromNSColor(colorSpace, _backgroundColor);
    CGColorSpaceRelease(colorSpace);
    CGContextSetFillColorWithColor(context, color);
    CGContextFillRect(context, NSRectToCGRect(dirtyRect));
    CGColorRelease (color);
}


@end
