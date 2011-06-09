//
//  OITDigitalReadoutController.m
//  lab3
//
//  Created by Travis Churchill on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITDigitalReadoutController.h"
#import "OITStyledView.h"

#define kXbuffer  10.0f
#define kYbuffer  15.0f

@implementation OITDigitalReadoutController

@synthesize value = _value;
@synthesize maxValue = _maxValue;
@synthesize delegate = _delegate;
@synthesize label = _label;
@synthesize decimalPlacement = _decimalPlacement;

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
        _value = 0;
        _maxValue = 10*digits - 1;
        _numberOfDigits = digits;
    }
    return self;
}

- (id)initWithNumberOfDigits:(int)digits AndDecimalPlaceAfterDigit:(int)decimalPlacing {
    self = [self initWithNumberOfDigits:digits];
    if (self) {
        [self setDecimalPlacement:decimalPlacing];
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
        [digitController.view setFrame:NSMakeRect(offsetX, height - kYbuffer, width, height)];
    }
    [self.view setFrame:NSMakeRect(self.view.frame.origin.x, self.view.frame.origin.y, (width + kXbuffer) * digitCount, height + kYbuffer)];
    [(OITStyledView*)self.view setBackgroundColor:[NSColor yellowColor]];
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
        [digit release];
    }
    _digitControllerArray = controllers;
    if (_decimalPlacement) {
        [[_digitControllerArray objectAtIndex:_decimalPlacement - 1] showDecimal:YES];
    }
}
- (void)setTitle:(NSString *)title {
//    [super setTitle:title];
    [_label setTitleWithMnemonic:title];
}

- (void)setValue:(float)value {
    float shift = 0;
    if (_decimalPlacement) shift = _numberOfDigits - _decimalPlacement;
    value = value * pow(10,shift);
    if ( value != _value ) {
        _value = lround(value) % lround(_maxValue);
        
        //set the digits right - to - left
        NSUInteger interimValue = value;
        for (NSUInteger i = _numberOfDigits; i >= 1 ; i--) {
            NSUInteger thisDigit = interimValue % 10;
            [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:i - 1] setValue:thisDigit];
            interimValue /= 10;
        }
        
//        NSUInteger tensDigit = round(_value / 10);
//        [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:0] setValue:tensDigit];
//        NSUInteger onesDigit = _value % 10;
//        [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:1] setValue:onesDigit];
    }
}

- (void)setMaxValue:(float)maxValue {
    if ( maxValue != _maxValue ) {
        _maxValue = maxValue;
        
        //set the digits right - to - left
        NSUInteger interimValue = lround(maxValue);
        for (NSUInteger i = _numberOfDigits; i >= 1 ; i--) {
            NSUInteger thisDigit = interimValue % 10;
            [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:i - 1] setMaxValue:thisDigit];
            interimValue /= 10;
        }
        
//        NSUInteger tensDigit = round (maxValue / 10);
//        [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:0] setMaxValue:tensDigit];
//        NSUInteger onesDigit = maxValue % 10;
//        [(OITSevenSegmentDigitController*)[_digitControllerArray objectAtIndex:1] setMaxValue:onesDigit];
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

- (void)setDecimalPlacement:(NSInteger)decimalPlacement {
    if (_decimalPlacement != decimalPlacement) {
        if (decimalPlacement > _numberOfDigits ) decimalPlacement = _numberOfDigits;
        if (decimalPlacement < 0) decimalPlacement = 0;
        _decimalPlacement = decimalPlacement;
    }
}

@end
