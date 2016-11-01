//
//  UIView+JuLayoutFrame.h
//  JuLayout
//
//  Created by Juvid on 16/7/17.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JuLayout.h"
///< 左右上高度
typedef struct JuLayEdgeHeight {
    CGFloat lead, trail, top, height;
} JuLayEdgeHeight;
UIKIT_STATIC_INLINE JuLayEdgeHeight JuEdgeHMake(CGFloat lead, CGFloat trail, CGFloat top, CGFloat height) {
    JuLayEdgeHeight julrth = {lead, trail, top, height};
    return julrth;
}
///< 上下左宽度
typedef struct JuLayEdgeWidth {
    CGFloat top, bottom, lead, width;
} JuLayEdgeWidth;
UIKIT_STATIC_INLINE JuLayEdgeWidth JuEdgeWMake(CGFloat top, CGFloat bottom, CGFloat lead, CGFloat width) {
    JuLayEdgeWidth jutblw = {top, bottom, lead, width};
    return jutblw;
}
///< X,Y,宽度，高度
typedef struct JuLayRect {
    CGFloat lead, top, width, height;
} JuLayRect;
UIKIT_STATIC_INLINE JuLayRect JuRectMake(CGFloat lead, CGFloat top, CGFloat width, CGFloat height) {
    JuLayRect jultwh = {lead, top, width, height};
    return jultwh;
}

@interface UIView(JuLayGroup)

/*
 *本类所以方法为辅助作用，只对同一个view相对约束
 */

/**
 *  XY坐标等于另一个view
 */
-(void(^)(UIView *view))juOriginEqual;

/**
 *  宽度高度坐标等于另一个view
 */
-(void(^)(UIView *view))juSizeEqual;

/**
 *  整个约束等于另一个View（一般是等于父view）
 */
-(void(^)(UIView *view))juFrameEqual;

/**
 *  XY约束:X（>0左边,<0右边，=0中间）,Y（>0顶端,<0底端，=0中间）
 */
-(void(^)(CGPoint origin))juOrigin;

/**
 *  宽度高度
 */
-(void(^)(CGSize size))juSize;

/**
 *  frame约束（xy等同juOrigin）
 */
-(void(^)(CGRect frame))juFrame;

/**
 *  四边约束
 */
-(void(^)(UIEdgeInsets edge))juEdge;
-(void(^)(UIEdgeInsets edge,UIView *view))juEdgeTo;

/**
 *  左,右 ,Y方向（>0顶端,<0底端，=0中间）,高度约束
 */
-(void(^)(JuLayEdgeHeight juEdgeH))juEdgeH;
-(void(^)(JuLayEdgeHeight juEdgeH,UIView *view))juEdgeHTo;

/**
 *  上,下, X方向（>0坐边,<0右边，=0中间）,高度约束
 */
-(void(^)(JuLayEdgeWidth juEdgeW))juEdgeW;
-(void(^)(JuLayEdgeWidth juEdgeW,UIView *view))juEdgeWTo;

/**
 *  X轴对齐:X轴（>0坐边,<0右边，=0中间），Y（上边）宽度，高度
 */
-(void(^)(JuLayRect juFrame))juAlignX;
-(void(^)(JuLayRect juFrame,UIView *view))juAlignXTo;

/**
 *  Y轴对齐:Y轴（>0坐边,<0右边，=0中间），X（左边边）宽度，高度
 */
-(void(^)(JuLayRect juFrame))juAlignY;
-(void(^)(JuLayRect juFrame,UIView *view))juAlignYTo;
@end
