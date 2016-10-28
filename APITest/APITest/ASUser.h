//
//  ASUser.h
//  APITest
//
//  Created by Антон  Смирнов on 22.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASUser : NSObject

@property (strong, nonatomic) NSString* firstName;

@property (strong, nonatomic) NSString* lastName;

@property (assign, nonatomic) BOOL online;

@property (strong, nonatomic) NSURL* imageURL;

@property (strong, nonatomic) NSString* user_id;

-(id) initWithServerResponse: (NSDictionary*) responseObject;
-(id) initWithServerResponse2: (NSDictionary*) responseObject;

@end
