//
//  OITStyledView.h
//  lab3
//
//  Created by Travis Churchill on 6/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 A view with a background color
 */
@interface OITStyledView : NSView {
@private
    NSColor* _backgroundColor;
}
@property (nonatomic, retain) NSColor *backgroundColor;
@end
