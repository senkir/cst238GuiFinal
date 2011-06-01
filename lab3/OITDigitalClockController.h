//
//  OITDigitalClockController.h
//  lab2DasClock
//
//  Created by Travis Churchill on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITClockController.h"
#import "OITTimeModel.h"
#import "OITSevenSegmentDigitController.h"

@interface OITDigitalClockController : OITClockController <OITSevenSegmentDigitDelegate> {
@private
    NSView* _hoursDisplay1;
    NSView* _hoursDisplay2;
    NSView* _minutesDisplay1;
    NSView* _minutesDisplay2;
    
    NSArray* _controllersArray;
}
@property (nonatomic, retain) IBOutlet NSView *hoursDisplay1;
@property (nonatomic, retain) IBOutlet NSView *hoursDisplay2;
@property (nonatomic, retain) IBOutlet NSView *minutesDisplay1;
@property (nonatomic, retain) IBOutlet NSView *minutesDisplay2;
@end
