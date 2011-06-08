//
//  OITAbstractClockElementController.h
//  lab2DasClock
//
//  Created by Travis Churchill on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface OITAbstractClockElementController : NSViewController {
    float  _value;
    float  _maxValue; //restricts the maximum value of this state
    
    //view relative elements
    float       _minDegrees;
    float       _maxDegrees;

}
@property (nonatomic, assign) float maxValue;
@property (nonatomic, assign) float value;
@property (nonatomic, assign) float minDegrees;
@property (nonatomic, assign) float maxDegrees;

- (void)incrementDigit;
- (void)updateDisplay;

@end
