//
//  AGagueController.m
//  lab3
//
//  Created by Travis Churchill on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AGagueController.h"


@implementation AGagueController

@synthesize allModels = _allModels;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //do stuff
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.view = [[NSView alloc] initWithFrame:frame];
        [self loadComponents];
    }
    return self;
}

- (void)dealloc
{
    [_allModels release];
    _allModels = nil;
    
    [super dealloc];
}

- (void)loadComponents {
    //does nothing here
}

-(void)modelDidUpdate:(AModel*)model {
    //does nothing here
}

@end
