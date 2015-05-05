//
//  SearchResultsTableViewCell.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/3/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "SearchResultsTableViewCell.h"


@interface SearchResultsTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *partyLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;


@end

@implementation SearchResultsTableViewCell


-(void)updateWithRepresentative:(Representative *)representative {
    
    self.nameLabel.text = representative.name;
    self.partyLabel.text = representative.party;
    self.stateLabel.text = representative.state;
    if ([representative.party isEqualToString:@"R"]) {
        self.partyLabel.textColor = [UIColor redColor];
    } else if([representative.party isEqualToString:@"D"]){
        self.partyLabel.textColor = [UIColor blueColor];
    }else if([representative.party isEqualToString:@"I"]){
        self.partyLabel.textColor = [UIColor purpleColor];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
