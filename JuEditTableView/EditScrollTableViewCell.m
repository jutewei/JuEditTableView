//
//  EditScrollTableViewCell.m
//  JuEditTableView
//
//  Created by Juvid on 2016/11/4.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "EditScrollTableViewCell.h"
#import "UIView+Frame.h"
#import "JuEditTableView.h"
#define cellEditWidth 220
@implementation EditScrollTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self shSetEditView];
    // Initialization code
}
-(void)shShowHideEdit:(BOOL)isShow{
    if (isShow) {
        [sh_contentView setContentOffset:CGPointMake(cellEditWidth, 0) animated:YES];
        [self shTapGesture];
    }else{
        [sh_contentView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self shRemoveGgesture:NO];
    }
}
///< 删除手势
-(void)shRemoveGgesture:(BOOL)isClose{
    [self removeGestureRecognizer:sh_closeEdit];
    sh_closeEdit=nil;
    if (isClose) {
        self.sh_EditTable.ju_editIndexPath=nil;
    }

}
-(void)shTapGesture{
    sh_closeEdit=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(colseEidt:)];
    [self addGestureRecognizer:sh_closeEdit];
    [self sh_EditTable];
}
-(JuEditTableView *)sh_EditTable{
    __weak JuEditTableView *table;
//    =(JuEditTableView *)self.sh_TableView;
//    table.ju=self;
//    table.ju_editIndexPath=[DetectionSystem SubView:self TableView:self.sh_TableView];
    return table;
}
-(void)shSetEditView{
    if (!sh_vieEdit) {
//        sh_LayContentR.constant=cellEditWidth;
        sh_contentView.alwaysBounceHorizontal=YES;

       UIView *sh_VieEdit=[[UIView alloc]init];
        sh_VieEdit.backgroundColor=[UIColor redColor];
        [sh_contentView addSubview:sh_VieEdit];
        sh_VieEdit.juTrail.equal(0);
        sh_VieEdit.juHeight.equal(0);
        sh_VieEdit.juWidth.equal(cellEditWidth);
        sh_VieEdit.juCenterY.equal(0);
        UIButton *btnEdit=[[UIButton alloc]init];
        [sh_VieEdit addSubview:btnEdit];
        btnEdit.juFrame(CGRectMake(0.01, 0.01, cellEditWidth/2, 0));
        [btnEdit setTitle:@"编辑" forState:UIControlStateNormal];
        btnEdit.tag=2;
        [btnEdit addTarget:self action:@selector(shTouchEdit:) forControlEvents:UIControlEventTouchUpInside];
        [btnEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnEdit.titleLabel.font=[UIFont systemFontOfSize:15];
        UIButton *btnDelete=[[UIButton alloc]init];
        [sh_VieEdit addSubview:btnDelete];
        btnDelete.juSizeEqual(btnEdit);
        btnDelete.juTop.equal(0.01);
        btnDelete.juLeaSpace.toView(btnEdit).equal(0);
        [btnDelete setTitle:@"删除" forState:UIControlStateNormal];
        [btnDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnDelete.tag=1;
        //        btnDelete.backgroundColor=[UIColor redColor];
        [btnDelete addTarget:self action:@selector(shTouchDetele:) forControlEvents:UIControlEventTouchUpInside];
        btnDelete.titleLabel.font=[UIFont systemFontOfSize:15];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
