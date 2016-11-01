//
//  TestTableView.m
//  TestSwift
//
//  Created by Juvid on 2016/10/31.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuEditTableView.h"
#import "UIView+tableView.h"
@implementation JuEditTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return  self;
//}
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event{
    CGRect rectInTableView = [self rectForRowAtIndexPath:_ju_editIndexPath];
    if (_ju_editIndexPath) {
        if (point.y>CGRectGetMinY(rectInTableView)&&point.y<CGRectGetMaxY(rectInTableView)) {
            return YES;
        }else{
            [self juTableEndEdit];
            return NO;
        }

    }
    return YES;
}
-(void)juTableEndEdit{
    if ([self.juDelegate respondsToSelector:@selector(JuHideEditCell)]) {
        [self.juDelegate JuHideEditCell];
    }
}
-(NSIndexPath *)juSubView:(UIView *)subview{
    _ju_editIndexPath = [subview juSubViewTable:self];
    [self deselectRowAtIndexPath:_ju_editIndexPath animated:YES];
    return _ju_editIndexPath;
}


@end

//下步操作后有跟新数据
@interface JuTableRowAction ()
@property (nonatomic,copy  ) JuHandler ju_handler;
@end

@implementation JuTableRowAction

+ (instancetype)rowActionWithTitle:(nullable NSString *)title image:(NSString *)imageName handler:(JuHandler)handler{
    JuTableRowAction *btnItems=[[JuTableRowAction alloc]init];
    [btnItems setTitle:title forState:UIControlStateNormal];
    return [[JuTableRowAction alloc]initWithTitle:title image:imageName handler:handler];
}
+ (instancetype)rowActionWithTitle:(nullable NSString *)title handler:(JuHandler)handler{
    return [self rowActionWithTitle:title image:nil handler:handler];
}
- (instancetype)initWithTitle:(nullable NSString *)title image:(NSString *)imageName handler:(JuHandler)handler{
    self=[super init];
    if (self) {
        [self addTarget:self action:@selector(juTouchEdit:) forControlEvents:UIControlEventTouchUpInside];
        [self setTitle:title forState:UIControlStateNormal];
        self.ju_handler=handler;
    }
    return self;

}
-(void)juTouchEdit:(UIButton *)sender{
    if (self.ju_handler) {
        JuEditTableView *table=(JuEditTableView *)[self juTableView];
        [table juTableEndEdit];
        NSIndexPath *indexPath=[self juSubViewTable:table];
        self.ju_handler(sender,indexPath);
    }
}


@end