//
//  AModel.h
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AModel;

@protocol ModelDelegate 
- (void)modelDidUpdate:(AModel*)sender;
@end

@interface AModel : NSObject {
@protected
    NSString*   _modelType;
    float _value;
    float _maxValue;
    float _minValue;
    float _delta;
    float _finalValue;
    id<ModelDelegate> _delegate;
}
@property (nonatomic, assign) float value;
@property (nonatomic, assign) float delta;
@property (nonatomic, retain) id<ModelDelegate> delegate;

- (void)incrementValueBy:(float) value;

- (void)incrementDeltaBy:(float) delta;

- (void)update;

- (void)setFinalValue:(float)value WithRate:(float)rate;
/**
 * Returns float value between 0 and 1 representing how full this model object is.
 */
- (float)percentOfMax;
@end
