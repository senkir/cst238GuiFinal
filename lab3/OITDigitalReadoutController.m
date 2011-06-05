//
//  OITDigitalReadoutController.m
//  lab3
//
//  Created by Travis Churchill on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITDigitalReadoutController.h"

#define kXbuffer  2.0f

@implementation OITDigitalReadoutController

@synthesize value = _value;
@synthesize maxValue = _maxValue;
@synthesize delegate = _delegate;
//@synthesize view = _view;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        //do stuff
//    }
//    
//    return self;
//}

- (id)initWithNumberOfDigits:(int)digits {
    self = [super initWithNibName:@"OITDigitalReadout" bundle:nil];
    if (self) {
//        _view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 50, 200)];
        _value = 0;
        _maxValue = 10*digits - 1;
        _numberOfDigits = digits;
    }
    return self;
}

- (void)dealloc {
    [_delegate release];
    _delegate = nil;
    
    [_digitControllerArray release];
    _digitControllerArray = nil;
    
    [super dealloc];
}

- (void)loadView {
    [super loadView];
    
    //do build loading stuff
    [self setupControllerArray];
    
    NSUInteger digitCount = [_digitControllerArray count];
    float offsetX = 0;
    float height = 0;
    float width = 0;
    for (int i = 0 ; i < digitCount ; i++) {
        OITSevenSegmentDigitController *digitController = [_digitControllerArray objectAtIndex:i];
        if (height == 0 || width == 0 ) {
            width = digitController.view.frame.size.width;
            height = height > 0 ? height : digitController.view.frame.size.height;
        }

        offsetX = (width + kXbuffer ) * i;
        [digitController.view setFrame:NSMakeRect(offsetX, height / 2, width, height)];
    }
    [self.view setFrame:NSMakeRect(0, height, (width + kXbuffer) * digitCount, height)];
//    [self.view setFrame:NSMakeRect(0, 0, 1200, 300)];
}

- (void)setupControllerArray {
    NSMutableArray* controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < _numberOfDigits ; i++) {
        OITSevenSegmentDigitController* digit = [[OITSevenSegmentDigitController alloc] initWithParentView:self.view];
        if (i == 0) {
            [digit setDelegate:self];
        } else {
            [digit setNextDigit:[controllers objectAtIndex:i - 1]];
        }
        [controllers addObject:digit];
    }
    _digitControllerArray = controllers;
    
}
- (void)setValue:(NSUInteger)value {
    if ( value != _value ) {
        _value = value % _maxValue;
        NSUInteger tensDigit = round(_value / 10);
        [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:0] setValue:tensDigit];
        NSUInteger onesDigit = _value % 10;
        [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:1] setValue:onesDigit];
    }
}

- (void)setMaxValue:(NSUInteger)maxValue {
    if ( maxValue != _maxValue ) {
        _maxValue = maxValue;
        NSUInteger tensDigit = round (maxValue / 10);
        [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:0] setMaxValue:tensDigit];
        NSUInteger onesDigit = maxValue % 10;
        [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:1] setMaxValue:onesDigit];
    }
}


- (void)incrementDigit {
    [[_digitControllerArray objectAtIndex:[_digitControllerArray count] -1] incrementDigit];
}

- (void)digitDidRollOver:(OITSevenSegmentDigitController *)sender {
    if ( _delegate != nil ) {
        [_delegate digitDidRollOver:self];
    }
}

@end
