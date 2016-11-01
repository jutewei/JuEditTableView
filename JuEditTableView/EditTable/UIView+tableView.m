//
//  UIView+tableView.m
//  JuEditTableView
//
//  Created by Juvid on 2016/11/1.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "UIView+tableView.h"

@implementation UIView (tableView)
-(NSIndexPath *)juSubViewTable:(UITableView *)tableView{
    UIView *superView=self.superview;
    if (!superView) return [NSIndexPath indexPathWithIndex:1];
    while (superView) {
        superView=[superView superview];
        if ([superView isKindOfClass:[UITableViewCell class]]) {
            break;
        }
    }
    NSIndexPath *_ju_editIndexPath = [tableView indexPathForCell:(UITableViewCell *)superView];
    return _ju_editIndexPath;
}
-(UITableView *)juTableView{
    UIView *superView=self.superview;
    while (superView) {
        superView=[superView superview];
        if ([superView isKindOfClass:[UITableView class]]) {
            break;
        }
    }
    return (UITableView *)superView;
}
@end
