//
//  RepresentativeController.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 4/30/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "RepresentativeController.h"
#import "Representative.h"


@implementation RepresentativeController

+ (RepresentativeController *)sharedInstance {
    static RepresentativeController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RepresentativeController new];
    });
    return sharedInstance;
}

- (void)searchForRepresentativesWithSearchString:(NSString *)searchString SearchType:(SearchType)searchType andCompletion:(void (^)(BOOL success))completion {
    self.representatives = [NSArray new];
    self.senators = [NSArray new];
    
    NSURL *url;
    switch (searchType) {
        case Name:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_reps_byname.php?name=%@&output=json",searchString]];
            [self searchForSenatorsWithSearchString:searchString andType:searchType];
            break;
        case State:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_reps_bystate.php?state=%@&output=json", searchString]];
            [self searchForSenatorsWithSearchString:searchString andType:searchType];
            break;
        case Zipcode:
             url = [NSURL URLWithString:[NSString stringWithFormat:@"http:whoismyrepresentative.com/getall_mems.php?zip=%@&output=json", searchString]];
            break;
    }
    
    NSError *error;
    NSArray *searchResults = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error]objectForKey:@"results"];
    // MutableArray to hold rep object results
    NSMutableArray *repResults = [NSMutableArray new];
    for (NSDictionary *dictionary in searchResults) {
        Representative *representative = [[Representative alloc]initWithDictionary:dictionary];
        [repResults addObject:representative];
    }
    // Include both rep & senator results from API search
    self.representatives = [repResults arrayByAddingObjectsFromArray:self.senators];
    completion(YES);
}

-(void)searchForSenatorsWithSearchString:(NSString *)searchString andType:(NSInteger)searchType{
    NSURL *url;
    switch (searchType) {
        case Name:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_sens_byname.php?name=%@&output=json", searchString]];
            break;
        case State:
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_sens_bystate.php?state=%@&output=json", searchString]];
            break;
    }
    NSError *error;
    NSArray *searchResults = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error] objectForKey:@"results"];
    
    NSMutableArray *senatorResults = [NSMutableArray new];
    for (NSDictionary *dictionary in searchResults) {
        Representative *representative = [[Representative alloc] initWithDictionary:dictionary];
        [senatorResults addObject:representative];
    }
        self.senators = senatorResults;
}


@end
