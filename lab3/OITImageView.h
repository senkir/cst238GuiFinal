//
//  OITImageView.h
//  lab2DasClock
//
//  Created by Travis Churchill on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OITImageView : NSImageView {
@private
    float _rotationInDegrees;
}

@property (nonatomic, assign) float rotationInDegrees;
@end
