//
//  RepresentativeController.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 4/30/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "RepresentativeController.h"

@implementation RepresentativeController

+(RepresentativeController *)sharedInstance {
    static RepresentativeController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RepresentativeController new];
    });
    return sharedInstance;
}

@end
