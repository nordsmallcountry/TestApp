//
//  Photo.h
//  APITest
//
//  Created by Антон  Смирнов on 29.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (strong, nonatomic) NSURL* imageURL;


- (id)initWithPhotoResponse: (NSDictionary*) responseObject ;

@end
