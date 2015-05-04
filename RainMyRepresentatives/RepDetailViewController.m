//
//  RepDetailViewController.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/4/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "RepDetailViewController.h"


@interface RepDetailViewController ()

@property (nonatomic, strong) Representative *currentRep;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabe;
@property (strong, nonatomic) IBOutlet UILabel *districtLabel;
@property (strong, nonatomic) IBOutlet UILabel *partyLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;


@property (strong, nonatomic) IBOutlet UIButton *textButton;
@property (strong, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) IBOutlet UIButton *locateOffice;
@property (strong, nonatomic) IBOutlet UIButton *websiteButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation RepDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.nameLabel.text = self.currentRep.name;
    self.stateLabe.text = self.currentRep.state;
    self.districtLabel.text = self.currentRep.district;
    [self.websiteButton setTitle:self.currentRep.link forState:UIControlStateNormal];
    self.addressLabel.text = self.currentRep.office;
    self.phoneLabel.text = self.currentRep.phone;
    
    if ([self.currentRep.party isEqualToString:@"R"]) {
        self.textButton.tintColor = [UIColor redColor];
        self.callButton.tintColor = [UIColor redColor];
        self.locateOffice.tintColor = [UIColor redColor];
        self.websiteButton.tintColor = [UIColor redColor];
        self.backButton.tintColor = [UIColor redColor];
        self.partyLabel.text = @"Republican";
    } else if ([self.currentRep.party isEqualToString:@"D"]){
        self.partyLabel.text = @"Democrat";
    }
        
    
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Updates from SearchVC prep for segue prior to view loading
- (void)updateWithRepresentative:(Representative *)representative {
    self.currentRep = representative;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
