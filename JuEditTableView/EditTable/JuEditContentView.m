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
@interface JuEditContentView ()<UIGestureRecognizerDelegate>{
    UIPanGestureRecognizer *ju_panGesture;
    UIView *ju_viewBack;
    CGFloat ju_itemsTotalW;
    __weak JuEditTableView *ju_parentTable;
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
-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.superview) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{///< 防止获取不到 indexPath
            self.isCanEdit=[self.sh_tableView isCanEdit:self.indexPath];
        });
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result = [super hitTest:point withEvent:event];
    if (result==self) {
        if (ju_EditStatus>=JuEditStatusAnimate&&ju_EditStatus<=JuEditStatusClose) {
            [self juEndMove];
            return nil;
        }
        self.isCanEdit=[self.sh_tableView isCanEdit:self.indexPath];
        ju_parentTable.slideIndexPath=self.indexPath;
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
        if (fabs(translation.y)>= fabs(translation.x)) {
            return NO; // 手势冲突，解决tableview不可拖动
        }
        if(![ju_parentTable.slideIndexPath isEqual:self.indexPath]){///< 防止多个一起滑动
            return NO;
        }
    }
    return YES;
}
///< 拖动出现编辑动画
- (void)dragContent:(UIPanGestureRecognizer *)pan{
    static  CGFloat viewOriginX=0;
    CGRect frame=pan.view.frame;
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        [self juStartEndMove:fabs(frame.origin.x)>40];///< 拖动停止实现动画
        return;
    }
    else if(pan.state==UIGestureRecognizerStateBegan){
        viewOriginX=pan.view.frame.origin.x;
        //        isFirstDrag=YES;
        ju_EditStatus=JuEditStatusFirstDrag;
    }
    else{
        if (fabs(viewOriginX)>0) {
            [self juEndMove];
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

///< 初始化
-(JuEditStatus)juSetRowActions:(BOOL)isLeft{
    UIView *supView=self.superview;
    if (!supView) return JuEditStatusNone;
    NSArray *items=isLeft?self.ju_leftRowAction:self.ju_RightRowAction;
    if (items.count==0) return JuEditStatusNone;
    _juOpenRight=isLeft;
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
        CGFloat itemW;
        if (btnItems.ju_itemWidth>0) {
            itemW=btnItems.ju_itemWidth;
        }else{
            itemW=[btnItems boundingWidth:200]+40;
        }
        {
            btnItems.juFrame(CGRectMake(itemLeft, 0, itemW, 0));
        }
        itemLeft+=itemW;
    }
    ju_viewBack.ju_Width.constant=itemLeft;
    ju_itemsTotalW=itemLeft;
    return isLeft?JuEditStatusLeft:JuEditStatusRight;
}
///<点击开启
-(void)setJuOpenRight:(BOOL)juOpenRight{
    _juOpenRight=juOpenRight;
    BOOL isClose=fabs(self.frame.origin.x)<10;
    if (isClose&&[self.sh_tableView isCanEdit:self.indexPath]) {
        ju_EditStatus=[self juSetRowActions:_juOpenRight];
    }
    [self juStartEndMove:isClose];
}
-(void)juStartEndMove:(BOOL)open{
    if (open) {
        CGFloat originx=self.frame.origin.x;///<防止左滑又右滑
        if ((ju_EditStatus==JuEditStatusRight&&originx<0)||(ju_EditStatus==JuEditStatusLeft&&originx>0)) {
            [self juEndMove];
            return;
        }
        
        [self juStartMove];
    }else{
        [self juEndMove];
    }
}
-(void)juStartMove{
    if (ju_itemsTotalW==0) return;
    if (ju_EditStatus==JuEditStatusAnimate) return;
    ju_EditStatus=JuEditStatusAnimate;
    [self shSetTableIndex];///< 出现编辑table不可滑动
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeTranslation(ju_itemsTotalW*(_juOpenRight?-1:1), 0);
    }completion:^(BOOL finished) {
        ju_EditStatus=JuEditStatusOpened;
    }];
}
///< 结束编辑
-(void)juEndMove{
    if (ju_EditStatus==JuEditStatusClose) return;
    ju_EditStatus=JuEditStatusClose;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [ju_viewBack removeFromSuperview];
        ju_viewBack=nil;
        ju_itemsTotalW=0;
        ju_parentTable.ju_editIndexPath=nil;///< 编辑结束可继续滑动
        ju_EditStatus=JuEditStatusNone;
    }];
}

#pragma mark cellDelegate
-(void)JuEndEditCell{
    [self juEndMove];
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
    __weak typeof(self) weakSelf=self;
    if(!ju_parentTable.ju_editIndexPath){
        ju_parentTable.ju_editIndexPath= self.indexPath;
        ju_parentTable.juEndEdit=^(){///< 每次需要重新赋值
            [weakSelf juEndMove];
        };
    }
}
-(NSArray<UIView *> *)ju_leftRowAction{
    return [self.sh_tableView ju_leftRowAction:self.indexPath];
}
-(NSArray<UIView *> *)ju_RightRowAction{
    return [self.sh_tableView ju_RightRowAction:self.indexPath];
}
-(NSIndexPath *)indexPath{
    return [self juSubViewTable:ju_parentTable];
}
@end
