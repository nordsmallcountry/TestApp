//
//  IndexPath.h
//  APITest
//
//  Created by Антон  Смирнов on 28.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexPath : NSObject

@property (strong, nonatomic) NSIndexPath* pathToCollection;


@property (strong, nonatomic) NSMutableArray* pathArray;

+ (instancetype)sharedIndex;

@end
