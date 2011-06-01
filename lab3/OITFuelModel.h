//
//  OITFuelModel.h
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FuelModelDelegate <NSObject>
- (void)fuelIsEmpty:(id)sender;
- (void)fuelDidDecrease:(id)sender;
@end

@interface OITFuelModel : NSObject {
@private
    NSNumber* _fuel;
    NSNumber* _maxFuel;
    id<FuelModelDelegate> _delegate;
}
@property (nonatomic, retain) NSNumber* fuel;
@property (nonatomic, retain) id<FuelModelDelegate> delegate;

- (void)refill:(NSNumber*)fuel;
- (void)decrement;

@end
