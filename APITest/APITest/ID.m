//
//  ID.m
//  APITest
//
//  Created by Антон  Смирнов on 27.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "ID.h"

@implementation ID

+ (instancetype)sharedID {
    static ID* sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ID alloc] init];
    });
    return sharedInstance;
}

@end
