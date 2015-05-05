//
//  SearchResultsTableViewCell.h
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/3/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Representative.h"

@interface SearchResultsTableViewCell : UITableViewCell

-(void)updateWithRepresentative:(Representative *)representative;
@end
