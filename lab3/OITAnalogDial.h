//
//  OITAnalogDial.h
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITAbstractClockElementController.h"
#import "OITImageView.h"

@class OITAnalogGagueBackgroundView;
@class OITClockAnalogHand;

@interface OITAnalogDial : OITAbstractClockElementController {
@private
    OITAnalogGagueBackgroundView* _background;
    CGRect                          _frame;
    OITImageView                   *_imageView;
    OITClockAnalogHand              *_imageViewController;
}

- (id)initWithFrame:(CGRect)frame;
@end
