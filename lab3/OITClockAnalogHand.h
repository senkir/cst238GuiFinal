//
//  OITClockAnalogHand.h
//  lab2DasClock
//
//  Created by Travis Churchill on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITAbstractClockElementController.h"
#import "OITImageView.h"

@interface OITClockAnalogHand : OITAbstractClockElementController {
@private
    OITImageView *_handImageView;
}
- (id)initWithImageView:(OITImageView*) imageView;
- (void)rotateByDegrees:(NSUInteger) degrees;
- (NSImageView*)image;
@end
