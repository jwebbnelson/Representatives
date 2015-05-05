//
//  WebViewController.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/4/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) Representative *currentRep;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:self.webView];
    [self.webView addSubview:self.navigationBar];
    [self configureView];
}

- (void)configureView {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.currentRep.link]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (IBAction)doneButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateWithRepresentative:(Representative *)representative {
    self.currentRep = representative;
}
@end
