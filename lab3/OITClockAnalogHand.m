//
//  OITClockAnalogHand.m
//  lab2DasClock
//
//  Created by Travis Churchill on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OITClockAnalogHand.h"

@implementation OITClockAnalogHand

- (id)initWithImageView:(OITImageView*) imageView {
    self = [super init];
    if (self) {
        _handImageView = [imageView retain];
        [self setMaxValue:60];
    }
    return self;
}

- (void)dealloc {
    [_handImageView release];
    _handImageView = nil;
    [super dealloc];
}

- (void)setValue:(float)value {
    [super setValue:value];
    [self updateDisplay];
}

#pragma mark OITClockAnalogHand

- (void)incrementDigit {
    //do stuff specific to analog clocks
    [self setValue:[self value] + 1];
    [self updateDisplay];
}

- (void)updateDisplay {
    //refresh the image if necessary
    int degrees = -(int)round(( (float)self.value / self.maxValue ) * 360);
    [_handImageView setRotationInDegrees:degrees];
    [_handImageView setNeedsDisplay:true];
}

- (void)drawInContext {
    NSLog(@"drawing in context");
    
}

static inline double rad(int alpha)
{
    return ((alpha * pi)/180);
}

- (NSImage *)rotateIndividualImage: (NSImage *)image clockwise: (BOOL)clockwise
{
//    NSImage *existingImage = image;
//    NSSize existingSize;
//    
    /**
     * Get the size of the original image in its raw bitmap format.
     * The bestRepresentationForDevice: nil tells the NSImage to just
     * give us the raw image instead of it's wacky DPI-translated version.
     */
//    existingSize.width = [[existingImage bestRepresentationForDevice: nil] pixelsWide];
//    existingSize.height = [[existingImage bestRepresentationForDevice: nil] pixelsHigh];
    
//    NSSize newSize = NSMakeSize(existingSize.height, existingSize.width);
//    NSImage *rotatedImage = [[NSImage alloc] initWithSize:newSize];
    
//    [rotatedImage lockFocus];
    
    /**
     * Apply the following transformations:
     *
     * - bring the rotation point to the centre of the image instead of
     *   the default lower, left corner (0,0).
     * - rotate it by 90 degrees, either clock or counter clockwise.
     * - re-translate the rotated image back down to the lower left corner
     *   so that it appears in the right place.
     */
//    NSAffineTransform *rotateTF = [NSAffineTransform transform];
//    NSPoint centerPoint = NSMakePoint(newSize.width / 2, newSize.height / 2);
//    
//    [rotateTF translateXBy: centerPoint.x yBy: centerPoint.y];
//    [rotateTF rotateByDegrees: (clockwise) ? - 90 : 90];
//    [rotateTF translateXBy: -centerPoint.y yBy: -centerPoint.x];
//    [rotateTF concat];
    
    /**
     * We have to get the image representation to do its drawing directly,
     * because otherwise the stupid NSImage DPI thingie bites us in the butt
     * again.
     */
//    NSRect r1 = NSMakeRect(0, 0, newSize.height, newSize.width);
//    [[existingImage bestRepresentationForDevice:nil] drawInRect: r1];
//    
//    [rotatedImage unlockFocus];
    
//    return rotatedImage;
    return nil;
}


- (void)rotateByDegrees:(NSUInteger) degrees {
//    
//    NSImage* rotatedImage = [[NSImage alloc] initWithSize:size];
//    NSSize size = [[_handImageView image] size];
//    NSPoint center = NSMakePoint(size.width / 2.0 , size.height / 2.0);
////    
//    NSAffineTransform *transform = [NSAffineTransform transform];
//    [rotatedImage lockFocus];
//    [transform translateXBy:center.x yBy:center.y];
//    [transform rotateByDegrees:degrees];
//    [transform translateXBy:-center.x yBy:-center.y];
//    [transform concat];
//    
//    [[_handImageView image] drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0 ];
//    [rotatedImage unlockFocus];
//    [_handImageView setImage:rotatedImage];
//    [_handImageView setNeedsDisplay];
//    
    
//    NSImage* image = [_handImageView image];
//    NSAffineTransform* transform = [NSAffineTransform transformRotatingAroundPoint:center byDegrees:degrees];
//    [OITImageHelper rotate:[_handImageView image] byDegrees:degrees];
    // alternate implementation
//    float factorW, factorH, dW, dH;
//    NSAffineTransform *centreOp, *rotateOp;
//    NSImage *tmpImage;
//    NSPoint startPoint;
//    NSGraphicsContext* graphicsContext;
//    BOOL wasAntialiasing;
//    NSImageInterpolation previousImageInterpolation;
//    
//    if (0 == alpha)
//        return;
//    factorW = fabs(cos(rad(alpha)));
//    factorH = fabs(sin(rad(alpha)));
//    dW = [image size].width * factorW + [image size].height * factorH;
//    dH = [image size].width * factorH + [image size].height * factorW;
//    tmpImage = [[NSImage alloc] initWithSize: NSMakeSize(dW, dH)];
//    
//    centreOp = [NSAffineTransform transform];
//    [centreOp translateXBy: dW / 2 yBy: dH / 2];
//    rotateOp = [NSAffineTransform transform];
//    [rotateOp rotateByDegrees: alpha];
//    [rotateOp appendTransform: centreOp];
//    
//    [image setMatchesOnMultipleResolution: NO];
//    [image setUsesEPSOnResolutionMismatch: YES];
//    [tmpImage lockFocus];
//    graphicsContext = [NSGraphicsContext currentContext];
//    wasAntialiasing = [graphicsContext shouldAntialias];
//    previousImageInterpolation = [graphicsContext imageInterpolation];
//    [graphicsContext setShouldAntialias: YES];
//    [graphicsContext setImageInterpolation: NSImageInterpolationHigh];
//    
//    [rotateOp concat];
//    startPoint = NSMakePoint(-[image size].width / 2, -[image
//                                                        size].height / 2);
//    [image drawAtPoint: startPoint
//              fromRect: NSMakeRect(0, 0, [image size].width, [image
//                                                              size].height)
//             operation: NSCompositeCopy
//              fraction: 1.0];
//    
//    [graphicsContext setShouldAntialias: wasAntialiasing];
//    [graphicsContext setImageInterpolation:
//     previousImageInterpolation];
//    [tmpImage unlockFocus];
//    [tmpImage setDataRetained: YES];
//    [tmpImage setScalesWhenResized: YES];
//    
//    [_handImageView setImage:tmpImage];
//    [_handImageView setNeedsDisplay:TRUE];
}

- (NSImageView*)image {
    return _handImageView;
}
@end
