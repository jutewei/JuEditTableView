//
//  UIView+Layout.h
//  testBlock
//
//  Created by Juvid on 16/7/17.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuLayout.h"
@interface UIView (JuLayout)

/**
 *  左边约束
 */
-(JuLayout *)juLead;

/**
 *  右边约束
 */
-(JuLayout *)juTrail;

/**
 *  底端约束
 */
-(JuLayout *)juTop;

/**
 *  底端约束
 */
-(JuLayout *)juBottom;

/**
 *  约束者的左边相对于约束对象右边（space）
 */
-(JuLayout *)juLeaSpace;

/**
 *  约束者的右边相对于约束对象左边（space）
 */
-(JuLayout *)juTraSpace;

/**
 *  约束者的顶端边相对于约束对象底端（space）
 */
-(JuLayout *)juTopSpace;
/**
 *  约束者的底端边相对于约束对象顶端（space）
 */
-(JuLayout *)juBtmSpace;

/**
 *  底端文本对齐
 */
-(JuLayout *)juLastLine;

/**
 *  顶端文本对齐
 */
-(JuLayout *)juFirLine;

/**
 *  X轴对齐
 */
-(JuLayout *)juCenterX;

/**
 *  Y轴对齐
 */
-(JuLayout *)juCenterY;

/**
 *  宽度（默认为父View时，0时等于父view宽度，>0时为自己实际宽度）
 */
-(JuLayout *)juWidth;

/**
 *  高度（默认为父View时，0时等于父view宽度，>0时为自己实际高度）
 */
-(JuLayout *)juHeight;

/**
 *  像素宽高比(W/H)Pixel Aspect Ratio Par
 */
-(JuLayout *)juAspectWH;


@end
