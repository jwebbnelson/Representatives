//
//  RepDetailViewController.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/4/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "RepDetailViewController.h"
#import "WebViewController.h"
#import <MessageUI/MessageUI.h>
#import "LocationViewController.h"

@interface RepDetailViewController () <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

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
    } else  if ([self.currentRep.party isEqualToString:@"I"]) {
            self.textButton.tintColor = [UIColor purpleColor];
            self.callButton.tintColor = [UIColor purpleColor];
            self.locateOffice.tintColor = [UIColor purpleColor];
            self.websiteButton.tintColor = [UIColor purpleColor];
            self.backButton.tintColor = [UIColor purpleColor];
            self.partyLabel.text = @"Republican";
    } else if ([self.currentRep.party isEqualToString:@"D"]){
        self.partyLabel.text = @"Democrat";
    }
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Text Compose Methods
- (IBAction)textButtonAction:(id)sender {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    NSArray *recipents = [NSArray arrayWithObject:self.currentRep.phone];
    NSString *message = @"Hello, I obtained your contact info via RainMyRepresentatives.";
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


// Call Representative
- (IBAction)callButtonAction:(id)sender {
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.currentRep.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

// Updates from SearchVC prep for segue prior to view loading
- (void)updateWithRepresentative:(Representative *)representative {
    self.currentRep = representative;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showLocationSegue"]) {
        LocationViewController *viewController = [segue destinationViewController];
        [viewController updateWithRepresentative:self.currentRep];
    }
    if ([segue.identifier isEqualToString:@"webViewSegue"]) {
        WebViewController *viewController = [segue destinationViewController];
        [viewController updateWithRepresentative:self.currentRep];
    }
}


@end
