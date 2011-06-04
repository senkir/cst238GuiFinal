//
//  OITGearBox.h
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AModel.h"


@interface OITGearBox : AModel {
@private
    NSArray         *_gears;
}
- (void)upshift;
- (void)downshift;

@end
