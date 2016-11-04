//
//  TestTableView.m
//  TestSwift
//
//  Created by Juvid on 2016/10/31.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuEditTableView.h"
#import "UIView+tableView.h"
#import "JuEditContentView.h"
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
    return  [super pointInside:point withEvent:event];
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView *result = [super hitTest:point withEvent:event];
//    if ([result isKindOfClass:[JuEditContentView class]]) {
//        JuEditContentView *contentV=(id)result;
//        NSIndexPath *indexPath=[contentV juSubViewTable:self];
//        contentV.isCanEdit=[self isCanEdit:indexPath];
//        self.slideIndexPath=indexPath;
//    }
//    return result;
//}
-(void)juTableEndEdit{
    if (self.juEndEdit) {
        self.juEndEdit();
    }
}
-(BOOL)isCanEdit:(NSIndexPath *)indexPath{
    if ([self.juDataSource respondsToSelector:@selector(juTableView:canEditRowAtIndexPath:)]&&indexPath) {
        return   [self.juDataSource juTableView:self canEditRowAtIndexPath:indexPath];
    }
    return self.ju_leftRowAction.count||self.ju_RightRowAction.count?YES:NO;
}

-(NSArray<UIView*>*)ju_leftRowAction{
    return [self ju_leftRowAction:nil];
}
-(NSArray<UIView*>*)ju_RightRowAction{
    return [self ju_RightRowAction:nil];
}
-(NSArray<UIView*>*)ju_leftRowAction:(NSIndexPath *)indexPath{
    if ([self.juDataSource respondsToSelector:@selector(juTableView: editActionsForRowAtIndexPath:)]&&indexPath) {
        return [self.juDataSource juTableView:self editActionsForRowAtIndexPath:indexPath];
    }
    return _ju_leftRowAction;
}
-(NSArray<UIView*>*)ju_RightRowAction:(NSIndexPath *)indexPath{
    if ([self.juDataSource respondsToSelector:@selector(juTableView: editLeftActionsForRowAtIndexPath:)]&&indexPath) {
        return [self.juDataSource juTableView:self editLeftActionsForRowAtIndexPath:indexPath];
    }
    return _ju_RightRowAction;
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
-(void)juTouchEdit:(JuTableRowAction *)sender{
    if (self.ju_handler) {
        JuEditTableView *table=(JuEditTableView *)[self juTableView];
        [table juTableEndEdit];
        NSIndexPath *indexPath=[self juSubViewTable:table];
        self.ju_handler(sender,indexPath);
    }
}


@end
