//
//  LocationViewController.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 5/4/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "LocationViewController.h"
#import "OfficeAnnotation.h"

@interface LocationViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) Representative *representative;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@end

@implementation LocationViewController

-(void)updateWithRepresentative:(Representative *)rep {
    self.representative = rep;
    [self geocodeWithAddress:self.representative.office];
    
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.representative.name;
}

-(void)geocodeWithAddress:(NSString*)address {
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            CLPlacemark *placeMark = [placemarks firstObject];
            self.location = placeMark.location.coordinate;
            [self setupMapView];
        }
        else {
            [self presentFailureAlert];
            return;
        }
    }];
}

-(void)setupMapView {
    MKCoordinateRegion region;
    region.center = self.location;
    region.span = MKCoordinateSpanMake(0.008, 0.008);
    [self.mapView setRegion:region animated:YES];
    
    OfficeAnnotation *annotation = [OfficeAnnotation new];
    annotation.title = self.representative.name;
    annotation.coordinate = self.location;
    annotation.subtitle = self.representative.office;
    [self.mapView showAnnotations:[NSArray arrayWithObject:annotation] animated:YES];
}

-(void)presentFailureAlert {
    UIAlertController *failAlert = [UIAlertController alertControllerWithTitle:@"Address Not Found" message:@"Check your connection and try again" preferredStyle:UIAlertControllerStyleAlert];
    
    [failAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:failAlert animated:YES completion:nil];
}
@end
