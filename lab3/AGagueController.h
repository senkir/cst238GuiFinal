//
//  AGagueController.h
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OITMeterManager.h"
/**
 Abstract implementation of a gague controller that the car controller class can interact with.
 */
@interface AGagueController : NSViewController <OITMeterManagerDelegate> {
@protected
    NSMutableDictionary*            _allModels;
}

//shorthand way to access any gagues in this controller
@property (nonatomic, retain) NSMutableDictionary *allModels; 

- (void)loadComponents;
@end
