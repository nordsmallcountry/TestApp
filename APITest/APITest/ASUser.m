//
//  ASUser.m
//  APITest
//
//  Created by Антон  Смирнов on 22.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "ASUser.h"

@implementation ASUser

- (id)initWithServerResponse: (NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        self.online = [responseObject objectForKey:@"online"];
        NSString* urlString = [responseObject objectForKey:@"photo_100"];
        
        if(urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        } 
    }
    return self;
}



@end
