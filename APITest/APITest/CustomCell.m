//
//  CustomCell.m
//  APITest
//
//  Created by Антон  Смирнов on 23.10.16.
//  Copyright © 2016 Антон  Смирнов. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
-(void) setLabel {
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 15)];//40
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myLabel setText:@"Hi Label"];
    //[[self view] addSubview:myLabel];
}
*/
@end
