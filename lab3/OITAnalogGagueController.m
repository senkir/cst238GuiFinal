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
#define kColumnsPerRow   5

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
    [_rpm setMinDegrees:-30.0f];
    [_rpm setMaxDegrees:210.0f];
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
    
    _gear = [[OITAnalogDial alloc] initWithFrame:CGRectMake(0, 0, kBaseDialWidth, kBaseDialHeight)];
    [_gear loadView];
    [self.view addSubview:[_gear view]];
    [_gear setMinDegrees:3.0f];
    [_gear setMaxDegrees:120.0f];
    [_gear setEndIndicatorText:[NSString stringWithFormat:@"%d", 5]];
    [_gear setStartIndicatorText:[NSString stringWithFormat:@"%d", 1]];
    [_gear setMaxValue:5.0];
    [_gear setTitleField:@"Gear"];
    
    _fuel = [[OITAnalogDial alloc] initWithFrame:CGRectMake(0, 0, kBaseDialWidth, kBaseDialHeight)];
    [_fuel loadView];
    [self.view addSubview:[_fuel view]];
    [_fuel setMinDegrees:0.0f];
    [_fuel setMaxDegrees:180.0f];
    [_fuel setEndIndicatorText:@"F"];
    [_fuel setStartIndicatorText:@"E"];
    [_fuel setMaxValue:12.0];
    [_fuel setTitleField:@"Fuel"];
    
    _oil = [[OITAnalogDial alloc] initWithFrame:CGRectMake(0, 0, kBaseDialWidth, kBaseDialHeight)];
    [_oil loadView];
    [self.view addSubview:[_oil view]];
    [_oil setMinDegrees:20.0f];
    [_oil setMaxDegrees:160.0f];
    [_oil setEndIndicatorText:@"100"];
    [_oil setStartIndicatorText:@"0"];
    [_oil setMaxValue:100.0];
    [_oil setTitleField:@"Oil"];
    
    _temp = [[OITAnalogDial alloc] initWithFrame:CGRectMake(0, 0, kBaseDialWidth, kBaseDialHeight)];
    [_temp loadView];
    [self.view addSubview:[_temp view]];
    [_temp setMinDegrees:20.0f];
    [_temp setMaxDegrees:160.0f];
    [_temp setEndIndicatorText:@"200"];
    [_temp setStartIndicatorText:@"70"];
    [_temp setMaxValue:200.0];
    [_temp setTitleField:@"Temp"];
    
    _charge = [[OITAnalogDial alloc] initWithFrame:CGRectMake(0, 0, kBaseDialWidth, kBaseDialHeight)];
    [_charge loadView];
    [self.view addSubview:[_charge view]];
    [_charge setMinDegrees:20.0f];
    [_charge setMaxDegrees:160.0f];
    [_charge setEndIndicatorText:@"100"];
    [_charge setStartIndicatorText:@"0"];
    [_charge setMaxValue:100.0];
    [_charge setTitleField:@"Battery"];
    
    _odometer = [[OITAnalogDial alloc] initWithFrame:CGRectMake(0, 0, kBaseDialWidth, kBaseDialHeight)];
    [_odometer loadView];
    [self.view addSubview:[_odometer view]];
    [_odometer setMinDegrees:20.0f];
    [_odometer setMaxDegrees:160.0f];
    [_odometer setEndIndicatorText:@"100"];
    [_odometer setStartIndicatorText:@"0"];
    [_odometer setMaxValue:100.0];
    [_odometer setTitleField:@"Miles"];
    
    _trip = [[OITAnalogDial alloc] initWithFrame:CGRectMake(0, 0, kBaseDialWidth, kBaseDialHeight)];
    [_trip loadView];
    [self.view addSubview:[_trip view]];
    [_trip setMinDegrees:20.0f];
    [_trip setMaxDegrees:160.0f];
    [_trip setEndIndicatorText:@"100"];
    [_trip setStartIndicatorText:@"0"];
    [_trip setMaxValue:100.0];
    [_trip setTitleField:@"Trip"];
    
    _allModels = [[NSMutableDictionary alloc] init];
    [_allModels setValue:_rpm forKey:@"rpm"];
    [_allModels setValue:_speed forKey:@"speed"];
    [_allModels setValue:_gear forKey:@"gearBox"];
    [_allModels setValue:_fuel forKey:@"fuel"];
    [_allModels setValue:_oil forKey:@"oil"];
    [_allModels setValue:_temp forKey:@"temp"];    
    [_allModels setValue:_charge forKey:@"charge"];
    
    [_allModels setValue:_odometer forKey:@"miles"];   
    [_allModels setValue:_trip forKey:@"trip"];    

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
