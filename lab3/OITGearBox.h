//
//  OITGearBox.h
//  lab3
//
//  Created by Travis Churchill on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AModel.h"

@class OITRPMModel;

@interface OITGearBox : AModel {
@private
    NSArray         *_gears;
    OITRPMModel     *_engine;
}
@property (nonatomic, retain) OITRPMModel *engine;

- (void)upshift;
- (void)downshift;
- (void)revUp;
- (void)revDown;
@end
