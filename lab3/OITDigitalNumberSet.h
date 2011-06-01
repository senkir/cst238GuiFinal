//
//  OITDigitalNumberSet.h
//  lab2DasClock
//
//  Created by Travis Churchill on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OITSevenSegmentDigitController.h"

/**
 Manages A set of numbers to facilitate interactions with 2-digit sets.
 */
@interface OITDigitalNumberSet : NSObject <OITSevenSegmentDigitDelegate>{
@private
    NSUInteger _value;
    NSUInteger _maxValue;
    NSArray* _digitControllerArray;
    id<OITSevenSegmentDigitDelegate> _delegate;
}

@property (nonatomic, assign) NSUInteger value;
@property (nonatomic, assign) NSUInteger maxValue;
@property (nonatomic, retain) id<OITSevenSegmentDigitDelegate> delegate;

- (id)initWithDisplay:(NSArray*)digitControllerArray;
- (void)incrementDigit;
@end
