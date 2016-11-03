//
//  UIView+tableView.m
//  JuEditTableView
//
//  Created by Juvid on 2016/11/1.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "UIView+tableView.h"
#import <objc/runtime.h>
@implementation UIView (tableView)
-(NSIndexPath *)juSubViewTable:(UITableView *)tableView{
    UIView *superView=self;
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
-(CGFloat)ju_itemWidth{
    return [objc_getAssociatedObject(self, @selector(ju_itemWidth)) floatValue];
}
-(void)setJu_itemWidth:(CGFloat)ju_itemWidth{
    objc_setAssociatedObject(self,  @selector(ju_itemWidth), @(ju_itemWidth), OBJC_ASSOCIATION_COPY);
}
@end
