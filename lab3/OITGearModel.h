//
//  OITGearModel.h
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AModel.h"


@interface OITGearModel : AModel {
@private
    float _ratio;
}
+ (OITGearModel*)gearWithRatio:(float)ratio;
- (float)ratio;
@end
