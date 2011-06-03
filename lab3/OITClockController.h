//
//  OITClockController.h
//  lab2DasClock
//
//  Created by Travis Churchill on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OITTimeModel.h"

@interface OITClockController : NSViewController <OITTimeModelDelegate> {
@private
}

- (void)updateTime;
- (void)initializeTime;
@end
