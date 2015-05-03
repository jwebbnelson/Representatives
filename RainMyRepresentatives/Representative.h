//
//  Representative.h
//  RainMyRepresentatives
//
//  Created by Jordan Nelson on 4/30/15.
//  Copyright (c) 2015 Jordan Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Representative : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *party;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *office;
@property (strong, nonatomic) NSString *link;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
