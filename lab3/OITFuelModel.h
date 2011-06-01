//
//  OITFuelModel.h
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AModel.h"

@protocol FuelModelDelegate <NSObject>
- (void)fuelIsEmpty:(id)sender;
@end

@interface OITFuelModel : AModel {
@private
    id<FuelModelDelegate> _delegate;
}
@property (nonatomic, retain) id<FuelModelDelegate> delegate;

- (void)refill;

@end
