//
//  OITAnalogDial.m
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITAnalogDial.h"
#import "OITAnalogGagueBackgroundView.h"
#import "OITClockAnalogHand.h"
#import "OITLogger.h"

#define kImagePointerName       @"dial.png"
#define kRotationOffset         90.0

@implementation OITAnalogDial

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _background = [[OITAnalogGagueBackgroundView alloc] initWithFrame:frame];
        _frame = frame;
        


    }
    return self;
}

- (void)dealloc
{
    [_background release];
    _background = nil;
    
    [super dealloc];
}

- (void)loadView {
    [super loadView];
    self.view = [[NSView alloc] initWithFrame:_frame];
//    self.view = [[OITAnalogGagueBackgroundView alloc] initWithFrame:CGRectMake(50, 50, 500, 500)];
//    [_background setFrame:self.view.frame];
    [self.view addSubview:_background];
//    [self.view setNeedsDisplay:true];
    
    NSImage* pointer = [NSImage imageNamed:kImagePointerName];
    //        NSRect pointerRect = NSMakeRect(originX + 10, originY - 10, bodyRect.size.width, bodyRect.size.height);
    _imageView = [[OITImageView alloc] initWithFrame:self.view.frame];
    [_imageView setImage:pointer];
    [self.view addSubview:_imageView];
    _imageViewController = [[OITClockAnalogHand alloc] initWithImageView:_imageView];
}

- (void)updateDisplay {
    [_imageView removeFromSuperview];
    [self.view addSubview:_imageView];

    float minRotation = _minDegrees;
    float maxRotation = _maxDegrees;
    float percentRotation = -_value / _maxValue;
    float finalRotation = (_maxDegrees - _minDegrees) * percentRotation + kRotationOffset;
    
    NSString* message = [NSString stringWithFormat:@"rotation: %f", finalRotation];
    [OITLogger logFromSender:[self description] warn:message];
    [_imageView setRotationInDegrees:lround(finalRotation)];
    [self.view setNeedsDisplay:true];
    [_imageView setNeedsDisplay:true];
}
@end
