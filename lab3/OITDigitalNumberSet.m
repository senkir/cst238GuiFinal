//
//  OITDigitalNumberSet.m
//  lab2DasClock
//
//  Created by Travis Churchill on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITDigitalNumberSet.h"

@implementation OITDigitalNumberSet

@synthesize value = _value;
@synthesize maxValue = _maxValue;
@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithDisplay:(NSArray *)digitControllerArray {

    if ( [digitControllerArray count] != 2 ) {
        NSLog(@"OITDigitalNumberSet not implemented for arrays of length %@.  bailing!", [digitControllerArray count]);
        return nil;
    }
    for (NSObject* object in digitControllerArray) {
        if ( ![object isKindOfClass:[OITSevenSegmentDigitController class]] ) {
            NSLog(@"Invalid initialization input!  bailing!");
            return nil;
        }
    }
    _digitControllerArray = [digitControllerArray retain];;
    [[_digitControllerArray objectAtIndex:1] setNextDigit:[_digitControllerArray objectAtIndex:0]];
    [[_digitControllerArray objectAtIndex:0] setDelegate:self];
    _maxValue = 59;
    return self;
}


- (void)dealloc
{
    [_digitControllerArray release];
    _digitControllerArray = nil;
    [_delegate release];
    _delegate = nil;
    [super dealloc];
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
