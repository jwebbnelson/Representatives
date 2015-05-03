//
//  HomeScreenViewController.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/3/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "RepresentativeController.h"
#import "HomeScreenTableViewCell.h"

@interface HomeScreenViewController () 

@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[RepresentativeController sharedInstance] searchForRepresentativesWithCompletion:^(BOOL success) {
        if (success) {
            
            NSLog(@"Success");
        }
    }];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    HomeScreenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell updateWithTitle:[self cellTitles][indexPath.row]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(NSArray *)cellTitles {
    return @[@"Name",@"Zipcode",@"State"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
