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

@property (strong, nonatomic) NSString* online;

@property (strong, nonatomic) NSURL* imageURL;

-(id) initWithServerResponse: (NSDictionary*) responseObject;

@end
