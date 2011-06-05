//
//  OITDigitalReadoutController.h
//  lab3
//
//  Created by Travis Churchill on 6/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OITSevenSegmentDigitController.h"

@interface OITDigitalReadoutController : NSViewController <OITSevenSegmentDigitDelegate>{
@private
    IBOutlet NSTextField *_label;
    NSUInteger _numberOfDigits;
    NSInteger _decimalPlacement;
    float _value;
    float _maxValue;
    NSArray* _digitControllerArray;
    id<OITSevenSegmentDigitDelegate> _delegate;
}
@property (nonatomic, assign) float value;
@property (nonatomic, assign) float maxValue;
@property (nonatomic, retain) id<OITSevenSegmentDigitDelegate> delegate;
@property (nonatomic, retain) NSTextField *label;
@property (nonatomic, assign) NSInteger decimalPlacement;

- (id)initWithNumberOfDigits:(int)digits;
- (id)initWithNumberOfDigits:(int)digits AndDecimalPlaceAfterDigit:(int)decimalPlacing;
- (void)setupControllerArray;
- (void)incrementDigit;
@end
