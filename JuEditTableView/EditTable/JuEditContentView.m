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
//    BOOL isLeftPan;///< 往哪边滑动
//    BOOL isCanDrag;///< 是否可滑动
//    BOOL isFirstLoad;///< 第一次加载view
    __weak JuEditTableView *ju_parentTable;
//    BOOL isAnimate;///< 正在执行动画
//    BOOL isFirstDrag;///< 第一次拖拽
    JuEditStatus ju_EditStatus;
}
@end

@implementation JuEditContentView


-(void)addPanGesture{
    if(!ju_panGesture){
        ju_panGesture= [[UIPanGestureRecognizer alloc] initWithTarget:self  action:@selector(dragContent:)];
        ju_panGesture.delegate = self;
    }
    [self addGestureRecognizer:ju_panGesture];
}
-(void)removePanGesture{
    if(ju_panGesture){
        [self removeGestureRecognizer:ju_panGesture];
        ju_panGesture=nil;
    }
}
-(void)addTapGesture{
    if(!ju_tapGesture){
        ju_tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContent:)];
    }
    [self addGestureRecognizer:ju_tapGesture];
}
-(void)removeTapGesture{
    [self removeGestureRecognizer:ju_tapGesture];
    ju_tapGesture=nil;
}
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.superview) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{///< 防止获取不到 indexPath
            self.isCanEdit=[self.sh_tableView isCanEdit:self];
        });
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result = [super hitTest:point withEvent:event];
    if (result==self) {
        self.isCanEdit=[self.sh_tableView isCanEdit:self];
    }
    return result;
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
//         NSLog(@"里面 %@ X:%f  Y:%f",gestureRecognizer,translation.x,translation.y);
        if (fabs(translation.y)>= fabs(translation.x)) {
            return NO; // 手势冲突，解决tableview不可拖动
        }
    }
//     NSLog(@"外面 %@ X:%f  Y:%f",gestureRecognizer,translation.x,translation.y);
    return YES;
}
-(NSArray<UIView *> *)ju_leftRowAction{
    return [self.sh_tableView ju_leftRowAction:self];
}
-(NSArray<UIView *> *)ju_RightRowAction{
    return [self.sh_tableView ju_RightRowAction:self];
}

-(JuEditStatus)juSetRowActions:(BOOL)isLeft{
    UIView *supView=self.superview;
    if (!supView) return NO;
    NSArray *items=isLeft?self.ju_leftRowAction:self.ju_RightRowAction;

    [self juDeselectTable:items.count];
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
    
    return items.count?(isLeft?JuEditStatusLeft:JuEditStatusRight):JuEditStatusNone;
}
////< 点击当前cell结束编辑
-(void)tapContent:(UITapGestureRecognizer *)tap{
    [self juEndEdit];
}
///< 结束编辑
-(void)juEndEdit{
    if (ju_EditStatus==JuEditStatusClose) return;
    ju_EditStatus=JuEditStatusClose;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [ju_viewBack removeFromSuperview];
        ju_viewBack=nil;
        ju_parentTable.ju_editIndexPath=nil;///< 编辑结束可继续滑动
//        [self addPanGesture];
        [self removeTapGesture];
        ju_EditStatus=JuEditStatusNone;
    }];
}
///< 可以开始编辑
-(void)juBeganEdit:(CGFloat)originX{

    if (fabs(originX)>40) {
        CGFloat originx=self.frame.origin.x;
        if ((ju_EditStatus==JuEditStatusRight&&originX<0)||(ju_EditStatus==JuEditStatusLeft&&originX>0)) {
             [self juEndEdit];
            return;
        }
        if (ju_EditStatus==JuEditStatusAnimate) return;
        ju_EditStatus=JuEditStatusAnimate;
         [self shSetTableIndex];///< 出现编辑table不可滑动
        [UIView animateWithDuration:0.2 animations:^{
           
            self.transform = CGAffineTransformMakeTranslation(ju_itemsTotalW*(originx<0?-1:1), 0);
        }completion:^(BOOL finished) {
            [self addTapGesture];
//            [self removePanGesture];
            ju_EditStatus=JuEditStatusNone;
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
//        isFirstDrag=YES;
        ju_EditStatus=JuEditStatusFirstDrag;
    }
    else{
        if (fabs(viewOriginX)>0) {
            [self juEndEdit];
            return;
        }

        CGFloat translationX = [pan translationInView:pan.view].x;
        if(pan.state==UIGestureRecognizerStateChanged&&ju_EditStatus==JuEditStatusFirstDrag){///< 获取滑动方向
            ju_EditStatus=[self juSetRowActions:translationX<0];
        }


        if (ju_EditStatus==JuEditStatusNone||(ju_EditStatus==JuEditStatusRight&&translationX<0)||(ju_EditStatus==JuEditStatusLeft&&translationX>0)) {///< 不能拖拽或者拖拽方向与开始相反
            pan.view.transform = CGAffineTransformMakeTranslation(MIN(translationX*0.4, 15), 0);
            return;
        }
       
        CGFloat transX=fabs(translationX);
        CGFloat originX;
        CGFloat totalX=frame.origin.x;
        if (fabs(totalX)>ju_itemsTotalW) {
            if (fabs(viewOriginX)>0) {///<防止第二次不在起始位置拖动
                originX=transX*0.3;
            }else{///< 实现阻尼效果
                originX=ju_itemsTotalW+(transX-ju_itemsTotalW)*0.3;
            }
        }else{///< 未到边界无阻尼
            originX=transX;
        }
        if (translationX<0) {
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
///< 取消table选中
-(void)juDeselectTable:(BOOL)isDrag{
    if (isDrag) {
        [self shSetTableIndex];///< 出现编辑table不可滑动
        [self.sh_tableView deselectRowAtIndexPath:ju_parentTable.ju_editIndexPath animated:NO];
    }
}
///< 设置当前row indexPath
-(void)shSetTableIndex{
    [self sh_tableView];
    ju_parentTable.juDelegate=self;///< 每次需要重新赋值
    ju_parentTable.ju_editIndexPath= [self juSubViewTable:ju_parentTable];
//    [ju_parentTable juSubView:self];
}
@end
