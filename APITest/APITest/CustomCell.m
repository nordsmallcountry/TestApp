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

        
    CustomCell* cell1 = self;
    dispatch_async(dispatch_get_main_queue(), ^{
    [cell1.avatar sd_setImageWithURL:user.imageURL
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  
                                  cell1.avatar.image = image;
                                 
                                  
                                  cell1.avatar.layer.cornerRadius = CGRectGetWidth(cell1.avatar.frame) / 2;
                                  cell1.avatar.clipsToBounds = YES;
                              }];
    });
}


@end
