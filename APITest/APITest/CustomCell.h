//
//  CustomCell.h
//  APITest
//
//  Created by Антон  Смирнов on 23.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASUser;

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIView *onlineView;

- (void) setCustomCellWith: (ASUser*) user;
@end
