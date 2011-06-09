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

#define kYbuffer        10.0
#define kXbuffer        20.0
#define kColumnsPerRow   3

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
    [_rpm setEndIndicatorText:[NSString stringWithFormat:@"%d", 8]];
    [_rpm setTitleField:@"RPM"];
    [_rpm setMaxValue:8000];
    
    _speed = [[OITAnalogDial alloc] initWithFrame:CGRectMake(0, 0, kBaseDialWidth, kBaseDialHeight)];
    [_speed loadView];
    [self.view addSubview:[_speed view]];
    [_speed setMinDegrees:0.0f];
    [_speed setMaxDegrees:180.0f];
    [_speed setEndIndicatorText:[NSString stringWithFormat:@"%d", 120]];
    [_speed setMaxValue:120.0];
    [_speed setTitleField:@"Speed"];
    
    _allModels = [[NSMutableDictionary alloc] init];
    [_allModels setValue:_rpm forKey:@"rpm"];
    [_allModels setValue:_speed forKey:@"speed"];
    
    NSArray* allControllers = [_allModels allValues];
    float yOffset = 0;
    float xOffset = 0;
    /******* Position Gagues ******/
    
    for (int i = 0; i < [allControllers count]; i++) {
        NSViewController* controller = [allControllers objectAtIndex:i];
        if (yOffset == 0 ) yOffset = controller.view.frame.size.height + kYbuffer;
        if ( 0 == i % kColumnsPerRow ) {
            yOffset += controller.view.frame.size.height + kYbuffer;
            xOffset = 0;
        }
        [[controller view] setFrame:NSMakeRect(xOffset,
                                               self.view.frame.size.height - controller.view.frame.size.height - yOffset,
                                               controller.view.frame.size.width, 
                                               controller.view.frame.size.height)];
        xOffset += controller.view.frame.size.width + kXbuffer;
    }
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
