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
//    IBOutlet NSView*     _view;
    NSUInteger _numberOfDigits;
    NSUInteger _value;
    NSUInteger _maxValue;
    NSArray* _digitControllerArray;
    id<OITSevenSegmentDigitDelegate> _delegate;
}
@property (nonatomic, assign) NSUInteger value;
@property (nonatomic, assign) NSUInteger maxValue;
@property (nonatomic, retain) id<OITSevenSegmentDigitDelegate> delegate;
//@property (nonatomic, retain) NSView *view;

- (id)initWithNumberOfDigits:(int)digits;
- (void)setupControllerArray;
- (void)incrementDigit;

@end
