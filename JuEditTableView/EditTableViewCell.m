//
//  EditTableViewCell.m
//  TestSwift
//
//  Created by Juvid on 2016/11/1.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "EditTableViewCell.h"
@interface EditTableViewCell (){
    
}

@end

@implementation EditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)shTouchLeft:(id)sender {
    ju_contentView.juOpenRight=NO;
//    [ju_contentView juOpenRight:NO];
}
- (IBAction)shTouchRight:(id)sender {
     ju_contentView.juOpenRight=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
