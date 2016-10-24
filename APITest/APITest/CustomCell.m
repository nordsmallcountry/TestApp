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
    
    self.avatar.layer.cornerRadius = CGRectGetWidth(self.avatar.frame) / 2;
    
    self.onlineView.layer.cornerRadius = CGRectGetWidth(self.onlineView.frame) / 2;
    
    self.avatar.clipsToBounds = YES;      
    
    self.onlineView.clipsToBounds = YES;
    
    
    
    if(!user.online) {
        
        
       self.onlineView.hidden = YES;
        
        
    } else self.onlineView.hidden = NO;
    if (user.imageURL !=nil) {
    
        NSURLRequest* request = [NSURLRequest requestWithURL:user.imageURL];
    
    
        __weak CustomCell* weakself = self;
    
        [weakself.avatar setImageWithURLRequest:request
                          placeholderImage: nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakself.avatar.image = image;
                                       
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                       
                                   }];
    }

    
}


@end
