//
//  OITCarController.m
//  lab3
//
//  Created by Travis Churchill on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITCarController.h"
#import "OITMeterManager.h"
#import "OITGearBox.h"

#import "OITSevenSegmentDigitController.h"
#import "OITDigitalNumberSet.h"

#import "OITRPMModel.h"
#import "OITVelocityModel.h"
#import "OITOilModel.h"
#import "OITTemperatureModel.h"
#import "OITChargeModel.h"
#import "OITOdometerModel.h"
#import "OITTripMeterModel.h"

#define kYbuffer        10.0
#define kXbuffer        20.0
#define kColumnsPerRow   3

@implementation OITCarController

@synthesize isOn = _isOn;
@synthesize lightsOn = _lightsOn;

static OITCarController *sharedInstance = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _meterManager = [[OITMeterManager alloc] init];
        [_meterManager setDelegate:self];
        _isOn = FALSE;
        _lightsOn = FALSE;
        
    }
    
    return self;
}

/** Singleton constructor **/
+ (OITCarController*)sharedOITCarController {
    @synchronized(self) {
        if (sharedInstance == nil) {
            [[self alloc] initWithNibName:@"OITCarController" bundle:nil];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (void)release
{
    // do nothing
}

- (id)autorelease
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}

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
    
    [_meterManager release];
    _meterManager = nil;
    
    [_thread release];
    _thread = nil;
    
    [_allModels release];
    _allModels = nil;
    
    [super dealloc];
}


- (void)loadView {
    [super loadView];
    [OITLogger logFromSender:[self description] message:@"loadView"];
    [self loadComponents];
    //TODO: intialize Gauges
//    [_digitalReadout1 loadView];
    //TODO: start listeners
    
    //TODO: turn the car on
    
    //TODO:  apply gas
//    [self becomeFirstResponder];
    
}

- (void)loadComponents {
    [OITLogger logFromSender:[self description] debug:@"Load components"];
    
    /***** Initial state of indicators *****/
    
    [_engineIndicatorView setBackgroundColor:[NSColor redColor]];
    [_lightIndicatorView setBackgroundColor:[NSColor grayColor]];
    
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
    
    for (int i = 1; i < [allControllers count]; i++) {
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
    
//    [[_speed view] setFrame:NSMakeRect(_speed.view.frame.size.width + _speed.view.frame.origin.x, self.view.frame.size.height - _speed.view.frame.size.height - kYbuffer, _speed.view.frame.size.width, _speed.view.frame.size.height)];

}

- (void)startUpdateTimer {
    [OITLogger logFromSender:[self description] message:@"start update timer"];
    _timerManager = [[OITTimerManager alloc] init];
    [_timerManager startTimerWithDelegate:self];
    _thread = [[NSThread alloc] initWithTarget:_timerManager selector:@selector(buildThread:) object:self];
}


- (IBAction)gasPedalPressed:(id)sender {
    [OITLogger logFromSender:[self description] message:@"gas pedal pressed"];
    if (_isOn) {
            [_meterManager gasPressed];
    }
}

- (IBAction)brakePedalPressed:(id)sender {
    [OITLogger logFromSender:[self description] message:@"brake pedal pressed"];
    [_meterManager brakePressed];
}

- (void)updateDisplay {
//    [OITLogger logFromSender:[self description] message:@"display should update!"];
    [_meterManager updateMeters];
    if (!_isOn && [_rpm value]) {
        [_meterManager brakePressed];
    }
}

//TODO:  fix this method.  it doesn't do anything yet.
//- (void)keyDown:(NSEvent *)theEvent {
//    [OITLogger logFromSender:[self description] message:@"key down event occured!"];
//}

- (IBAction)shiftUp:(id)sender {
    [[_meterManager gearBox] upshift];
}
- (IBAction)shiftDown:(id)sender {
    [[_meterManager gearBox] downshift];
}
- (IBAction)toggleCarOn:(id)sender {
    if (_isOn) {
        _isOn = false;
        [_carOnButton setTitleWithMnemonic:@"Turn &On"];
        [_engineIndicatorView setBackgroundColor:[NSColor redColor]];
    } else {
        _isOn = true;
        [_carOnButton setTitleWithMnemonic:@"Turn &Off"];
        [_engineIndicatorView setBackgroundColor:[NSColor grayColor]];
        [self gasPedalPressed:nil];
    }
    [_engineIndicatorView setNeedsDisplay:TRUE];
}

- (IBAction)toggleLights:(id)sender {
    if (_lightsOn) {
        _lightsOn = false;
        [_lightsButton setTitleWithMnemonic:@"&Lights On"];
        [_lightIndicatorView setBackgroundColor:[NSColor grayColor]];
    } else {
        _lightsOn = true;
        [_lightsButton setTitleWithMnemonic:@"&Lights Off"];
        [_lightIndicatorView setBackgroundColor:[NSColor yellowColor]];
    }
    [_lightIndicatorView setNeedsDisplay:TRUE];
}

-(void)modelDidUpdate:(AModel*)model {
    
    //use the dictionary we made earlier to match the key values
    OITDigitalReadoutController* gague = [_allModels valueForKey:[model modelType]];
    if (gague == nil) {
        NSString* message = [NSString stringWithFormat:@"No Gague found For Model %@", [model description]];
        [OITLogger logFromSender:[self description] error:message];
    } else {
        if ([[model modelType] isEqualToString:@"miles"]) {
            [OITLogger logFromSender:[self description] debug:@"Miles gague detected"];
        }
        float viewCoefficient = 1.0f;
        if ([[model modelType] isEqualToString:@"rpm"]) {
            viewCoefficient = 1.0f/1000.0f;
        }
        [gague setValue:[model value]*viewCoefficient];
    }
    
    
    //todo: refactor this into the observer pattern
    
//    if ([model isKindOfClass:[OITRPMModel class]]) {
//        [_rpm setValue:[model value]/1000];
//    } else if ([model isKindOfClass:[OITVelocityModel class]]) {
//        [_speed setValue:[model value]];
//    } else if ([model isKindOfClass:[OITFuelModel class]]) {
//        [_fuel setValue:[model value]];
//    } else if ([model isKindOfClass:[OITGearBox class]]) {
//        [_gear setValue:[model value]];
//    } else if ([model isKindOfClass:[OITOilModel class]]) {
//        [_oil setValue:[model value]];
//    } else if ([model isKindOfClass:[OITTemperatureModel class]]) {
//        [_temp setValue:[model value]];
//    } else if ([model isKindOfClass:[OITChargeModel class]]) {
//        [_charge setValue:[model value]];
//    } else if ([model isKindOfClass:[OITOdometerModel class]]) {
//        if (<#condition#>) {
//            <#statements#>
//        }
//    }
    
//    if (_isOn && [_rpm value] == 0) [self toggleCarOn:false];
}
         
 - (void)respondToNotification {
     //do stuff 
 }


- (IBAction)resetTrip:(id)sender {
    [_meterManager resetTrip];
}

- (IBAction)refillGas:(id)sender {
    [_meterManager refillGas];
}

@end
