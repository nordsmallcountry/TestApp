//
//  CustomImageCell.m
//  APITest
//
//  Created by Антон  Смирнов on 28.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "CustomImageCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"
@implementation CustomImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) setCustomCellWith: (Photo*) photo {
    
    
   dispatch_async(dispatch_get_main_queue(), ^{
        [self.avatar2 sd_setImageWithURL:photo.imageURL
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  
                                  self.avatar2.image = image;
                                  
                                  //self.imageCellCollection.layer.cornerRadius = CGRectGetWidth(self.imageCellCollection.frame) / 2;
                                  self.avatar2.clipsToBounds = YES;
                              }];
    });
   
    
    
    
}

@end
