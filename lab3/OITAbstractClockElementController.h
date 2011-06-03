//
//  OITAbstractClockElementController.h
//  lab2DasClock
//
//  Created by Travis Churchill on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface OITAbstractClockElementController : NSViewController {
@private
    NSUInteger _value;
    NSUInteger _maxValue; //restricts the maximum value of this state

}
@property (nonatomic, assign) NSUInteger maxValue;
@property (nonatomic, assign) NSUInteger value;

- (void)incrementDigit;
- (void)updateDisplay;

@end
