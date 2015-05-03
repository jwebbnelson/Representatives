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
#import "SearchViewController.h"

@interface HomeScreenViewController () <UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HomeScreenTableViewCell *cell = sender;
    SearchViewController *searchViewController = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [searchViewController updateWithSearchType:indexPath.row];
}

#pragma mark - TableView DataSource Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    HomeScreenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell updateWithTitle:[self cellTitles][indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(NSArray *)cellTitles {
    return @[@"Name",@"State",@"Zipcode"];
}

#pragma mark - TableView Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
