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
}
@property (nonatomic, assign) float value;

- (void)incrementBy:(float) value;

- (void)decrementBy:(float) value;

/**
 * Returns float value between 0 and 1 representing how full this model object is.
 */
- (float)percentOfMax;
@end
