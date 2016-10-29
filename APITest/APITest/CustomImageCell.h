//
//  CustomImageCell.h
//  APITest
//
//  Created by Антон  Смирнов on 28.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;

@interface CustomImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar2;

- (void) setCustomCellWith: (Photo*) photo ;

@end
