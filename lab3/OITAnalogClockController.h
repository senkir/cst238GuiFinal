//
//  OITAnalogClockController.h
//  lab2DasClock
//
//  Created by Travis Churchill on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITClockController.h"
#import "OITClockAnalogHand.h"

@class OITImageView;

@interface OITAnalogClockController : OITClockController {
@private
    NSImageView *_clockBody;
    OITImageView *_secondsHand;
    OITImageView *_minutesHand;
    OITImageView *_hoursHand;
    
    OITClockAnalogHand *_secondsHandController;
    OITClockAnalogHand *_minutesHandController;
    OITClockAnalogHand *_hoursHandController;
}

@property (nonatomic, retain) IBOutlet NSImageView *clockBody;
//@property (nonatomic, retain) IBOutlet NSImageView *secondsHand;
//@property (nonatomic, retain) IBOutlet NSImageView *minutesHand;
//@property (nonatomic, retain) IBOutlet NSImageView *hoursHand;

- (void)initializeTime;
- (void)relinkAllImages;
@end
