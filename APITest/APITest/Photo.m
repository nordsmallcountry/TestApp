//
//  Photo.m
//  APITest
//
//  Created by Антон  Смирнов on 29.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (id)initWithPhotoResponse: (NSDictionary*) responseObject {
    self = [super init];
    if (self) {
        if (responseObject[@"src"]) {
            NSString* urlString = [responseObject objectForKey:@"src"];
            if(urlString) {
                self.imageURL = [NSURL URLWithString:urlString];
            }
            
        }
    }
    
    return self;
}


@end
