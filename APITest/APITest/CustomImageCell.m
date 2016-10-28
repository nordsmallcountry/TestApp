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
@implementation CustomImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setCustomImageCellWith: (ASUser*) user {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.imageView sd_setImageWithURL:user.imageURL
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  
                                  self.imageView.image = image;
                                  
                                  
                                  //self.imageCellCollection.layer.cornerRadius = CGRectGetWidth(self.imageCellCollection.frame) / 2;
                                  self.imageView.clipsToBounds = YES;
                              }];
    });
}

@end
