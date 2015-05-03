//
//  HomeScreenTableViewCell.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/3/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "HomeScreenTableViewCell.h"

@interface HomeScreenTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation HomeScreenTableViewCell

-(void)updateWithTitle:(NSString *)title {
    
    self.titleLabel.text = title;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
