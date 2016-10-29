//
//  CustomCell.m
//  APITest
//
//  Created by Антон  Смирнов on 23.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "CustomCell.h"
#import "ASUser.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) setCustomCellWith: (ASUser*) user {

    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        
    self.onlineView.layer.cornerRadius = CGRectGetWidth(self.onlineView.frame) / 2;
    
        
    
    self.onlineView.clipsToBounds = YES;
    
    
    
    if(!user.online) {
        
        
       self.onlineView.hidden = YES;
        
        
    } else self.onlineView.hidden = NO;
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.avatar sd_setImageWithURL:user.imageURL
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  
                                  self.avatar.image = image;
                                 
                                  
                                 self.avatar.layer.cornerRadius = CGRectGetWidth(self.avatar.frame) / 2;
                                 self.avatar.clipsToBounds = YES;
                                  
                                  
                              }];
    });
}


@end
