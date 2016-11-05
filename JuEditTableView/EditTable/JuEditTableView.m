//
//  TestTableView.m
//  TestSwift
//
//  Created by Juvid on 2016/10/31.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuEditTableView.h"
#import "UIView+tableView.h"

@interface JuEditTableView (){
//    NSIndexPath *lastIndexPath;
   __weak UIPanGestureRecognizer *ju_ScrollViewPan;
}

@end

@implementation JuEditTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        for (UIPanGestureRecognizer *pan in self.gestureRecognizers) {
            if ([pan isKindOfClass:[UIPanGestureRecognizer class]]) {
                ju_ScrollViewPan=pan;
                [ju_ScrollViewPan addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"jutableview"];
            }
        }
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"state"]) {
        UIGestureRecognizerState panState=[change[@"new"] integerValue];
        if (panState==UIGestureRecognizerStateEnded&&self.ju_ContentView.isStartEdit) {
            [self.ju_ContentView juEndMove];
        }
    }
//    if (![lastIndexPath isEqual:self.indexPath]) {
//        if (self.ju_ContentView.isStartEdit) {
//            [self.ju_ContentView juEndMove:0];
//        }
//    }
//    lastIndexPath=self.indexPath;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event{
    if (self.ju_ContentView.isStartEdit) {
         CGRect rectInTableView = [self rectForRowAtIndexPath:self.indexPath];
        if (point.y>CGRectGetMinY(rectInTableView)&&point.y<CGRectGetMaxY(rectInTableView)) {
            return YES;
        }else{
             [self.ju_ContentView juEndMove];
            return NO;
        }
    }
    return  [super pointInside:point withEvent:event];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result = [super hitTest:point withEvent:event];
    if (result.superview.tag==1989918) {
        if (![result isKindOfClass:[JuTableRowAction class]]) {
             [self.ju_ContentView juEndMove];
        }
        NSLog(@"content");
    }
    return result;
}
-(NSIndexPath *)indexPath{
    return [self.ju_ContentView juSubViewTable:self];
}
/**
 设置滑动手势
 */
-(void)setJu_ContentView:(JuEditContentView *)ju_ContentView{
    _ju_ContentView=ju_ContentView;
    _ju_ContentView.isCanEdit=[self cellCanEdit];
}
-(BOOL)cellCanEdit{
    if ([self.juDataSource respondsToSelector:@selector(juTableView:canEditRowAtIndexPath:)]) {
        return   [self.juDataSource juTableView:self canEditRowAtIndexPath:self.indexPath];
    }
//    return self.ju_leftRowAction.count||self.ju_RightRowAction.count?YES:NO;
     return NO;
}

-(NSArray<UIView*>*)juLeftRowAction{
    if ([self.juDataSource respondsToSelector:@selector(juTableView: editActionsForRowAtIndexPath:)]) {
        return [self.juDataSource juTableView:self editActionsForRowAtIndexPath:self.indexPath];
    }
    if ([self.juDataSource respondsToSelector:@selector(juTableViewLeftRowActions)]) {
      return  [self.juDataSource juTableViewLeftRowActions];
    }
    return nil;
}
-(NSArray<UIView*>*)juRightRowAction{
    if ([self.juDataSource respondsToSelector:@selector(juTableView: editLeftActionsForRowAtIndexPath:)]) {
        return [self.juDataSource juTableView:self editLeftActionsForRowAtIndexPath:self.indexPath];
    }
    if ([self.juDataSource respondsToSelector:@selector(juTableViewRightRowActions)]) {
        return  [self.juDataSource juTableViewRightRowActions];
    }
    return nil;
}
-(void)dealloc{
     [ju_ScrollViewPan removeObserver:self forKeyPath:@"state" context:@"jutableview"];
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
        JuEditTableView *table=(id)[self juTableView];
        [table.ju_ContentView juEndMove];
        NSIndexPath *indexPath=[self juSubViewTable:table];
        self.ju_handler(sender,indexPath);
    }
}
-(void)dealloc{
    ;
}

@end
