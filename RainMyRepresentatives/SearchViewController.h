//
//  SearchViewController.h
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/3/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, SearchType) {
    Name,
    State,
    Zipcode,
};

@interface SearchViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, assign) SearchType searchType;

-(void)updateWithSearchType:(SearchType)searchType;

@end
