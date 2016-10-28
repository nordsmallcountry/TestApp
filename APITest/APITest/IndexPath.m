//
//  IndexPath.m
//  APITest
//
//  Created by Антон  Смирнов on 28.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "IndexPath.h"

@implementation IndexPath

+ (instancetype)sharedIndex {
    static IndexPath* sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IndexPath alloc] init];
    });
    return sharedInstance;
}


@end
