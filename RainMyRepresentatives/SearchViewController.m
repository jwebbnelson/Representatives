//
//  SearchViewController.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/3/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "SearchViewController.h"
#import "RepresentativeController.h"
#import "SearchResultsTableViewCell.h"
#import "RepDetailViewController.h"

@interface SearchViewController () <UITextFieldDelegate,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) NSArray *representativeResults;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [RepresentativeController sharedInstance].representatives = nil;
    [self.tableView reloadData];
   
    switch (self.searchType) {
        case Name:
            self.searchTextField.placeholder = @"Enter Representative name";
            break;
        case Zipcode:
            self.searchTextField.placeholder = @"Enter Zipcode";
            self.searchTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            break;
        case State:
            self.searchTextField.placeholder = @"Enter state abbreviaton";
            break;
    }
}

-(void)beginApiSearchInBackgroundWithSearchString {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[RepresentativeController sharedInstance]searchForRepresentativesWithSearchString:self.searchTextField.text SearchType:self.searchType andCompletion:^(BOOL success) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.representativeResults = [RepresentativeController sharedInstance].representatives;
                    [self.tableView reloadData];
            });
            } else {
                [self showFailureAlert];
            }
        }];
    });
}

-(void)showFailureAlert {
    UIAlertController *searchFailureAlert = [UIAlertController alertControllerWithTitle:@"Search Failed" message:@"Review search input text" preferredStyle:UIAlertControllerStyleAlert];
    
    [searchFailureAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:searchFailureAlert animated:YES completion:nil];
}

-(void)updateWithSearchType:(SearchType)searchType {
    self.searchType = searchType;
    // [conroller shared] reps = nil
}

// Return to home screen
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Remove Keyboard upon return button selection
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self beginApiSearchInBackgroundWithSearchString];
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[RepresentativeController sharedInstance].representatives count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    [cell updateWithRepresentative:[RepresentativeController sharedInstance].representatives[indexPath.row]];
    return cell;
}

#pragma mark - PrepForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailsSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RepDetailViewController *viewController = [segue destinationViewController];
        [viewController updateWithRepresentative:self.representativeResults[indexPath.row]];
    }
}


@end
