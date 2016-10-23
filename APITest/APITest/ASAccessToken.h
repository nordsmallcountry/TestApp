//
//  ASAccessToken.h
//  APITest
//
//  Created by Антон  Смирнов on 23.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAccessToken : NSObject

@property (strong, nonatomic) NSString* token;

@property (strong, nonatomic) NSDate* expirationDate;

@property (strong, nonatomic) NSString* userID; 

@end
