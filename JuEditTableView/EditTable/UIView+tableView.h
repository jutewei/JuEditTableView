//
//  UIView+tableView.h
//  JuEditTableView
//
//  Created by Juvid on 2016/11/1.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (tableView)
-(NSIndexPath *)juSubViewTable:(UITableView *)tableView;
-(UITableView *)juTableView;
-(id)JuEditContentView;
@property (nonatomic) CGFloat ju_itemWidth;///< 指定侧滑按钮宽度
@end
