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
    UIView *superView=self;
    if (!superView) return [NSIndexPath indexPathWithIndex:1];
    while (superView) {
        if ([superView isKindOfClass:[UITableViewCell class]]) {
            break;
        }
        superView=[superView superview];
    }
    NSIndexPath *_ju_editIndexPath = [tableView indexPathForCell:(UITableViewCell *)superView];
    return _ju_editIndexPath;
}
-(UITableView *)juTableView{
    UIView *superView=self;
    while (superView) {

        if ([superView isKindOfClass:[UITableView class]]) {
            break;
        }
        superView=[superView superview];
    }
    return (UITableView *)superView;
}
@end
