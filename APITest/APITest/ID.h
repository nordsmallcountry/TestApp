//
//  ID.h
//  APITest
//
//  Created by Антон  Смирнов on 27.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ID : NSObject

@property (strong, nonatomic) NSString* idToCollection;

+ (instancetype)sharedID;

@end
