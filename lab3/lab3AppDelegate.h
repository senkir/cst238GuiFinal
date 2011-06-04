//
//  lab3AppDelegate.h
//  lab3
//
//  Created by Travis Churchill on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OITCarController.h"

@interface lab3AppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    IBOutlet NSView *_view;
    IBOutlet OITCarController *_carController;
}

@property (assign) IBOutlet NSWindow *window;

@end
