//
//  AModel.h
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AModel : NSObject {
@protected
    float _value;
    float _maxValue;
    float _delta;
}
@property (nonatomic, assign) float value;
@property (nonatomic, assign) float delta;

- (void)incrementValueBy:(float) value;

- (void)decrementValueBy:(float) value;

- (void)incrementDeltaBy:(float) delta;

- (void)decrementDeltaBy:(float) delta;

/**
 * Returns float value between 0 and 1 representing how full this model object is.
 */
- (float)percentOfMax;
@end
