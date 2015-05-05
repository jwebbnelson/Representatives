//
//  LocationViewController.h
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/4/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Representative.h"
#import <MapKit/MapKit.h> 

@interface LocationViewController : UIViewController

-(void)updateWithRepresentative:(Representative *)rep;

@end
