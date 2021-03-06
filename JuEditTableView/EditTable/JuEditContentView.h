//
//  EditCellContentView.h
//  TestSwift
//
//  Created by Juvid on 2016/11/1.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,JuEditStatus){
    JuEditStatusNone        = 0,///< 静止状态 归零状态
    JuEditStatusLoad        = 1,///< 第一次加载
    /* 拖拽状态*/
    JuEditStatusDragBegan   = 2,///< 开始拖拽
    JuEditStatusDragLeft    = 3,///< 往左拖拽
    JuEditStatusDragRight   = 4,///< 往右拖拽
    /*动画状态*/
    JuEditStatusOpening     = 5,///< 正在移动开始动画
    JuEditStatusOpened      = 6,///< 编辑态
    JuEditStatusCloseing    = 7,///< 正在执行关闭动画
};///<三个同时存在并且优先级一样就会冲突

@interface JuEditContentView : UIView
///< 结束编辑
-(void)juEndMove;
@property (nonatomic) BOOL isStartEdit;
@property (nonatomic) BOOL juOpenRight;
@property (nonatomic,assign) BOOL isCanEdit;
@end
