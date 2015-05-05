//
//  RepresentativeController.h
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 4/30/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchViewController.h"

@interface RepresentativeController : NSObject

+ (RepresentativeController *)sharedInstance;
- (void)searchForRepresentativesWithSearchString:(NSString *)searchString SearchType:(SearchType)searchType andCompletion:(void (^)(BOOL success))completion;

@property (nonatomic, strong) NSArray *representatives;
@property (nonatomic, strong) NSArray *senators;

@end
