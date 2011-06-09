//
//  OITDigitalGagueController.m
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITDigitalGagueController.h"
#import "OITDigitalReadoutController.h"
#import "OITCarController.h"

#import "OITLogger.h"


#define kYbuffer        10.0
#define kXbuffer        20.0
#define kColumnsPerRow   3

@implementation OITDigitalGagueController

- (void)dealloc
{
    [_rpm release];
    _rpm = nil;
    [_speed release];
    _speed = nil;
    [_gear release];
    _gear = nil;
    [_fuel release];
    _fuel = nil;
    [_oil release];
    _oil = nil;
    [_temp release];
    _temp = nil;
    [_charge release];
    _charge = nil;
    [_odometer release];
    _odometer = nil;
    [_trip release];
    _trip = nil;
    
    [super dealloc];
}

- (void)loadComponents {
    [OITLogger logFromSender:[self description] debug:@"Load components"];
    
    /***** Load the Gagues *****/
    
    _rpm = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:3 AndDecimalPlaceAfterDigit:1];
    [_rpm loadView];
    [_rpm setTitle:@"RPM"];
    [self.view addSubview:[_rpm view]]; 
    
    _speed = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:4 AndDecimalPlaceAfterDigit:3];
    [_speed loadView];
    [_speed setTitle:@"Speed"];
    [self.view addSubview:[_speed view]];
    
    _fuel = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:3 AndDecimalPlaceAfterDigit:2];
    [_fuel loadView];
    [_fuel setTitle:@"Fuel"];
    [self.view addSubview:[_fuel view]];
    
    _gear = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:1];
    [_gear loadView];
    [_gear setTitle:@"Gear"];
    [self.view addSubview:[_gear view]];
    
    _oil = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:4 AndDecimalPlaceAfterDigit:3];
    [_oil loadView];
    [_oil setTitle:@"Oil"];
    [self.view addSubview:[_oil view]];
    
    _temp = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:4 AndDecimalPlaceAfterDigit:3];
    [_temp loadView];
    [_temp setTitle:@"Temp"];
    [self.view addSubview:[_temp view]];
    
    _charge = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:4 AndDecimalPlaceAfterDigit:3];
    [_charge loadView];
    [_charge setTitle:@"Battery"];
    [self.view addSubview:[_charge view]];
    
    _odometer = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:7 AndDecimalPlaceAfterDigit:6];
    [_odometer loadView];
    [_odometer setTitle:@"Miles"];
    [self.view addSubview:[_odometer view]];
    
    _trip = [[OITDigitalReadoutController alloc] initWithNumberOfDigits:7 AndDecimalPlaceAfterDigit:6];
    [_trip loadView];
    [_trip setTitle:@"Trip"];
    [self.view addSubview:[_trip view]];
    
    //convenience method that i need to use someplace
    
    _allModels = [[NSMutableDictionary alloc] init];
    [_allModels setValue:_rpm forKey:@"rpm"];
    [_allModels setValue:_speed forKey:@"speed"];
    [_allModels setValue:_fuel forKey:@"fuel"];
    [_allModels setValue:_gear forKey:@"gearBox"];
    [_allModels setValue:_oil forKey:@"oil"];
    [_allModels setValue:_temp forKey:@"temp"];
    [_allModels setValue:_charge forKey:@"charge"];
    [_allModels setValue:_odometer forKey:@"miles"];
    [_allModels setValue:_trip forKey:@"trip"];
    
    NSArray* allControllers = [_allModels allValues];
    NSUInteger xOffset = 0;
    NSUInteger yOffset = kYbuffer;
    
    /******* Position Gagues ******/
    
    for (int i = 0; i < [allControllers count]; i++) {
        NSViewController* controller = [allControllers objectAtIndex:i];
        [[controller view] setFrame:NSMakeRect(xOffset,
                                               self.view.frame.size.height - controller.view.frame.size.height - yOffset,
                                               controller.view.frame.size.width, 
                                               controller.view.frame.size.height)];
        xOffset += controller.view.frame.size.width + kXbuffer;
        if ( 0 == i % kColumnsPerRow ) {
            yOffset += controller.view.frame.size.height + kYbuffer;
            xOffset = 0;
        }
    }
    
    [self.view setNextResponder:[OITCarController sharedOITCarController].view];
}

-(void)modelDidUpdate:(AModel*)model {
    
    //use the dictionary we made earlier to match the key values
    OITDigitalReadoutController* gague = [_allModels valueForKey:[model modelType]];
    if (gague == nil) {
        NSString* message = [NSString stringWithFormat:@"No Gague found For Model %@", [model description]];
        [OITLogger logFromSender:[self description] error:message];
    } else {
        float viewCoefficient = 1.0f;
        if ([[model modelType] isEqualToString:@"rpm"]) {
            viewCoefficient = 1.0f/1000.0f;
        }
        [gague setValue:[model value]*viewCoefficient];
    }
    //    if (_isOn && [_rpm value] == 0) [self toggleCarOn:false];
}

@end
