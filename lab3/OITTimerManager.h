//
//  OITTimerModel.h
//  lab3
//
//  Created by Travis Churchill on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * This should be executed on a background thread
 */
@protocol OITTimeManagerDelegate <NSObject>
- (void)updateDisplay;
@end

@interface OITTimerManager : NSObject {
@private
    NSTimer* _updateTimer;
    id<OITTimeManagerDelegate> _delegate;
}
@property (nonatomic, retain) id<OITTimeManagerDelegate> delegate;

- (void)startTimerWithDelegate:(id<OITTimeManagerDelegate>)delegate;
@end
