//
//  OITTimeModel.h
//  lab2DasClock
//
//  Created by Travis Churchill on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This model provides a lot of the core functionality to the clock.
 Specifically, it tells the controller when the time has changed.
*/
@protocol OITTimeModelDelegate <NSObject>
@optional
- (void)secondsShouldUpdate:(NSDate*)timeStamp;

@optional
- (void)minutesShouldUpdate:(NSDate*)timeStamp;

@optional
- (void)hoursShouldUpdate:(NSDate*)timeStamp;
@end

@interface OITTimeModel : NSObject {
@private
    NSDate *_referenceDate;
    id<OITTimeModelDelegate> _delegate;
    NSTimer* _secondTimer;
    NSTimer* _minuteTimer;
}
@property (nonatomic, assign) NSDate *referenceDate;
@property (nonatomic, retain) id<OITTimeModelDelegate> delegate;
@end
