//
//  OITOdometerModel.h
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AModel.h"

@class OITOdometerModel;

@protocol OITOdometerDelegate <NSObject>

- (float) milesTraveled:(OITOdometerModel*)model;

@end


@interface OITOdometerModel : AModel {
@private
    
}

@end
