//
//  OITAnalogGagueController.m
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITAnalogGagueController.h"

#import "OITCarController.h"
#import "OITLogger.h"

#define kBaseDialHeight     120.0f
#define kBaseDialWidth      120.0f

@implementation OITAnalogGagueController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [_rpm release];
    _rpm = nil;
    
    [super dealloc];
}

- (void)loadComponents {
    [OITLogger logFromSender:[self description] debug:@"Load components"];

    _rpm = [[OITAnalogDial alloc] initWithFrame:CGRectMake(0, 0, kBaseDialWidth, kBaseDialHeight)];
    [_rpm loadView];
    [self.view addSubview:[_rpm view]];
    [_rpm setMinDegrees:0.0f];
    [_rpm setMaxDegrees:180.0f];
    [_rpm setMaxValue:8000];
    
//    _speed = [[OITAnalogDial alloc] initWithFrame:CGRectMake(500, 500, kBaseDialWidth, kBaseDialHeight)];
//    [_speed loadView];
//    [self.view addSubview:[_rpm view]];
//    [_speed setMinDegrees:0.0f];
//    [_speed setMaxDegrees:180.0f];
//    [_speed setMaxValue:.07];
    
    _allModels = [[NSMutableDictionary alloc] init];
    [_allModels setValue:_rpm forKey:@"rpm"];
//    [_allModels setValue:_speed forKey:@"speed"];
    
//    float yOffset = 0;
//    float xOffset = 0;
//    for (int i = 1; i < [_allModels count]; i++) {
//        NSViewController* controller = [_allModels objectAtIndex:i];
//        [[controller view] setFrame:NSMakeRect(xOffset,
//                                               self.view.frame.size.height - controller.view.frame.size.height - yOffset,
//                                               controller.view.frame.size.width, 
//                                               controller.view.frame.size.height)];
//        xOffset += controller.view.frame.size.width + 5;
//        if ( 0 == i % 5 ) {
//            yOffset += controller.view.frame.size.height + 5;
//            xOffset = 0;
//        }
//    }
    
//    [_rpm.view setFrame:CGRectMake(0, self.view.frame.size.height - kBaseDialHeight, kBaseDialWidth, kBaseDialHeight)];
//    [_rpm.view setNeedsDisplay:true];
    
//    [self.view setNextResponder:[OITCarController sharedOITCarController].view];

}

-(void)modelDidUpdate:(AModel*)model {
    
    //use the dictionary we made earlier to match the key values
    OITAnalogDial* gague = [_allModels valueForKey:[model modelType]];
    if (gague == nil) {
        NSString* message = [NSString stringWithFormat:@"No Gague found For Model %@", [model description]];
        [OITLogger logFromSender:[self description] error:message];
    } else {
//        float viewCoefficient = 1.0f;
        [gague setValue:[model value]];
        
    }
    //    if (_isOn && [_rpm value] == 0) [self toggleCarOn:false];
}

@end
