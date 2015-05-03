//
//  Representative.m
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 4/30/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import "Representative.h"


@implementation Representative

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    // Update Rep properties with dictionary parameter
    if (self) {
        self.name = dictionary[@"name"];
        self.state = dictionary[@"state"];
        self.party = dictionary[@"party"];
        self.district = dictionary[@"district"];
        self.phone = dictionary[@"phone"];
        self.office = dictionary[@"office"];
        self.link = dictionary[@"link"];
    }
    return self;
}
@end
