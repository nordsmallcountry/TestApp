//
//  ASAccessToken.m
//  APITest
//
//  Created by Антон  Смирнов on 23.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "ASAccessToken.h"

@implementation ASAccessToken

+ (instancetype)sharedToken {
    static ASAccessToken* sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ASAccessToken alloc] init];
    });
    return sharedInstance;
}


@end
