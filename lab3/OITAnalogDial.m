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

#define kRadius                 20.0

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
    
    //clear the view
    self.view = [[NSView alloc] initWithFrame:_frame];
    
    //add the background object
    [self.view addSubview:_background];
    
    //build some indicators
    _startIndicator = [[NSTextField alloc] initWithFrame:[self positionForDegrees:_minDegrees]];
    [_startIndicator setTitleWithMnemonic:[NSString stringWithFormat:@"%d", 0]];
    [_startIndicator setSelectable:false];
    [_startIndicator setBordered:false];
    [_startIndicator setBackgroundColor:[NSColor clearColor]];
    [self.view addSubview:_startIndicator];
    
    _endIndicator = [[NSTextField alloc] initWithFrame:[self positionForDegrees:_maxDegrees]];
    [_endIndicator setTitleWithMnemonic:[NSString stringWithFormat:@"%d", lround(_maxValue)]];
    [_endIndicator setSelectable:false];
    [_endIndicator setBordered:false];
    [_endIndicator setBackgroundColor:[NSColor clearColor]];
    [self.view addSubview:_endIndicator];
    
    //the pointer for the gague
    NSImage* pointer = [NSImage imageNamed:kImagePointerName];
    _imageView = [[OITImageView alloc] initWithFrame:self.view.frame];
    [_imageView setImage:pointer];
    [self.view addSubview:_imageView];
    _imageViewController = [[OITClockAnalogHand alloc] initWithImageView:_imageView];
}

- (void)updateDisplay {
    [_imageView removeFromSuperview];
    [self.view addSubview:_imageView];
    
    float percentRotation = -_value / _maxValue;
    float finalRotation = (_maxDegrees - _minDegrees) * percentRotation + kRotationOffset;
    
    NSString* message = [NSString stringWithFormat:@"rotation: %f", finalRotation];
    [OITLogger logFromSender:[self description] debug:message];
    [_imageView setRotationInDegrees:lround(finalRotation)];
    [self.view setNeedsDisplay:true];
    [_imageView setNeedsDisplay:true];
}

- (void)setMinDegrees:(float)minDegrees {
    [super setMinDegrees:minDegrees];
    [_startIndicator setFrame:[self positionForDegrees:_minDegrees]];
}

- (void)setMaxDegrees:(float)maxDegrees {
    [super setMaxDegrees:maxDegrees];
    [_endIndicator setFrame:[self positionForDegrees:_maxDegrees]];
}

- (void)setStartIndicatorText:(NSString*)text {
    [_startIndicator setTitleWithMnemonic:text];
}

- (void)setEndIndicatorText:(NSString*)text {
    [_endIndicator setTitleWithMnemonic:text];
}

- (void)setTitleField:(NSString*)title {
    if (_titleLabel == nil) {
        _titleLabel = [[NSTextField alloc] initWithFrame:[self positionForDegrees:90]];
        [_titleLabel setBordered:false];
        [_titleLabel setBackgroundColor:[NSColor clearColor]];
        [self.view addSubview:_titleLabel];
    }
    [_titleLabel setTitleWithMnemonic:title];
}

- (NSRect)positionForDegrees:(float)degrees {
    float centerX = self.view.frame.size.width / 2;
    float centerY =  self.view.frame.size.height / 2;
    
    float shiftX = (centerX - kRadius) * cos([self degreesToRadians:degrees + 180]);
    float shiftY = (centerY - kRadius) * sin([self degreesToRadians:degrees + 180]);
    NSRect toReturn = NSMakeRect(centerX + shiftX - kRadius/2, centerY + shiftY, kRadius*4, kRadius);
    return toReturn;
}

- (float)degreesToRadians:(float)degrees {
    return degrees * pi/180;
}
@end
