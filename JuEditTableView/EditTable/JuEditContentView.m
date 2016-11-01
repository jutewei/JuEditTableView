//
//  EditCellContentView.m
//  TestSwift
//
//  Created by Juvid on 2016/11/1.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuEditContentView.h"
#import "UIView+Frame.h"
#import "JuEditTableView.h"
#import "UIView+tableView.h"
@interface JuEditContentView ()<UIGestureRecognizerDelegate,EditTableViewDelegate>{
    UIPanGestureRecognizer *ju_panGesture;
    UITapGestureRecognizer *ju_tapGesture;
    UIView *ju_viewBack;
    CGFloat ju_itemsTotalW;
    BOOL isLeftPan;
    __weak JuEditTableView *ju_parentTable;
    BOOL isAnimate;
}
@property (nonatomic,strong)NSArray<UIView*> *ju_leftRowAction;
@property (nonatomic,strong)NSArray<UIView*> *ju_RightRowAction;
@end

@implementation JuEditContentView


-(void)addPanGesture{
    ju_panGesture= [[UIPanGestureRecognizer alloc] initWithTarget:self  action:@selector(dragContent:)];
    ju_panGesture.delegate = self;
    [self addGestureRecognizer:ju_panGesture];
}
-(void)removePanGesture{
    [self removeGestureRecognizer:ju_panGesture];
    ju_panGesture=nil;
}
-(void)addTapGesture{
    ju_tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContent:)];
    [self addGestureRecognizer:ju_tapGesture];
}
-(void)removeTapGesture{
    [self removeGestureRecognizer:ju_tapGesture];
    ju_tapGesture=nil;
}

-(void)setIsCanEdit:(BOOL)isCanEdit{
    _isCanEdit=isCanEdit;
    if (_isCanEdit) {
        [self addPanGesture];
    }
    else{
        [self removePanGesture];
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint translation = [ju_panGesture translationInView:self];
    if (gestureRecognizer==ju_panGesture) {
        if (fabs(translation.y) > fabs(translation.x)) {
            return NO; // 手势冲突，解决tableview不可拖动
        }
    }
    return YES;
}
-(NSArray<UIView *> *)ju_leftRowAction{
    if (!_ju_leftRowAction) {
        self.ju_leftRowAction=self.sh_tableView.ju_leftRowAction;
    }
    return _ju_leftRowAction;
}
-(NSArray<UIView *> *)ju_RightRowAction{
    if (!_ju_RightRowAction) {
        self.ju_leftRowAction=self.sh_tableView.ju_RightRowAction;
    }
    return _ju_RightRowAction;
}

-(void)juSetRowActions:(BOOL)isLeft{
    UIView *supView=self.superview;
    if (!supView) return;
    NSArray *items=isLeft?self.ju_leftRowAction:self.ju_RightRowAction;
    if (!ju_viewBack) {
        [ju_viewBack removeFromSuperview];
        ju_viewBack=nil;
    }
    ju_viewBack=[[UIView alloc]init];
    [ju_viewBack setClipsToBounds:YES];
    [supView insertSubview:ju_viewBack belowSubview:self];
    {
        ju_viewBack.juFrame(CGRectMake((isLeft?-.01:.01), 0, 60, 0));
    }
    CGFloat itemLeft=0.01;
    for (int i=0; i<items.count; i++) {
        UIButton *btnItems=items[i];
        [ju_viewBack addSubview:btnItems];
        CGFloat itemW=[btnItems boundingWidth:200]+40;
        {
            btnItems.juFrame(CGRectMake(itemLeft, 0, itemW, 0));
        }
        itemLeft+=itemW;
    }
    ju_viewBack.ju_Width.constant=itemLeft;
    ju_itemsTotalW=itemLeft;
}
////< 点击当前cell结束编辑
-(void)tapContent:(UITapGestureRecognizer *)tap{
    [self juEndEdit];
}
///< 结束编辑
-(void)juEndEdit{
    if (isAnimate) return;
    isAnimate=YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [ju_viewBack removeFromSuperview];
        ju_viewBack=nil;
        ju_parentTable.ju_editIndexPath=nil;///< 编辑结束可继续滑动
        [self addPanGesture];
        [self removeTapGesture];
        isAnimate=NO;
    }];
}
///< 可以开始编辑
-(void)juBeganEdit:(CGFloat)originX{

    if (fabs(originX)>40) {
         if (isAnimate) return;
         isAnimate=YES;
         [self shSetTableIndex];///< 出现编辑table不可滑动
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeTranslation(-ju_itemsTotalW, 0);
        }completion:^(BOOL finished) {
            [self addTapGesture];
            [self removePanGesture];
            isAnimate=NO;
        }];
    }else{
        [self juEndEdit];
    }
}
///< 拖动出现编辑动画
- (void)dragContent:(UIPanGestureRecognizer *)pan{
    static  CGFloat viewOriginX=0;
    CGRect frame=pan.view.frame;
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        [self juBeganEdit:frame.origin.x];///< 拖动停止实现动画
        return;
    }
    else if(pan.state==UIGestureRecognizerStateBegan){
        viewOriginX=pan.view.frame.origin.x;
        [self juSetRowActions:YES];///< 开始拖动时初始化编辑按钮
    }
    else{
        CGPoint translation = [pan translationInView:pan.view];
        if (translation.x>0) {
            return;
        }
        CGFloat transX=fabs(translation.x);
        CGFloat originX;
        CGFloat totalX=frame.origin.x;
        if (fabs(totalX)>ju_itemsTotalW) {
            if (fabs(viewOriginX)>0) {///<防止第二次不在起始位置拖动
                originX=transX*0.4;
            }else{///< 实现阻尼效果
                originX=ju_itemsTotalW+(transX-ju_itemsTotalW)*0.4;
            }
        }else{///< 未到边界无阻尼
            originX=transX;
        }
        if (translation.x<0) {
            originX=-originX;
        }
        pan.view.transform = CGAffineTransformMakeTranslation(originX+viewOriginX, 0);
    }
}
#pragma mark cellDelegate
-(void)JuHideEditCell{
    [self juEndEdit];
}
-(JuEditTableView *)sh_tableView{
    if(!ju_parentTable){
        ju_parentTable=(JuEditTableView *)[self juTableView];
    }
    return ju_parentTable;
}


///< 设置当前row indexPath
-(void)shSetTableIndex{
    [self sh_tableView];
    ju_parentTable.juDelegate=self;///< 每次需要重新赋值
    [ju_parentTable juSubView:self];
}
@end
