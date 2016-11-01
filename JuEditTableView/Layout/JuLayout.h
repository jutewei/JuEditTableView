//
//  JuLayout.h
//  testBlock
//
//  Created by Juvid on 16/7/17.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+JuConstraint.h"

@interface JuLayout : NSObject

@property BOOL isMinus;///< 只能为

@property (nonatomic,weak)UIView *juView2;
@property (nonatomic,weak)UIView *juView1;

@property (nonatomic) CGFloat juMulti;
@property (nonatomic) NSLayoutAttribute juAttr1;
@property (nonatomic) NSLayoutAttribute juAttr2;
@property (nonatomic) CGFloat juConstant;
@property (readonly)  NSLayoutRelation juRelation;
@property UILayoutPriority prioritys;
@property (nonatomic) JuLayoutType juLayoutType;
/**
 *  倍数
 */
-(JuLayout *(^)(CGFloat  mulits))multi;

/**
 *  相对view（约束）
 */
-(JuLayout *(^)(UIView * toItem))toView;

/**
 *  优先级（基本可以不用）
 */
-(JuLayout *(^)(CGFloat  prioritys))priority;

/**最终设置约束*/
/**
 *  等于
 */
-(NSLayoutConstraint *(^)(CGFloat constion))equal;

/**
 *  大于
 */
-(NSLayoutConstraint *(^)(CGFloat constion))greaterEqual;

/**
 *  小于
 */
-(NSLayoutConstraint *(^)(CGFloat constion))lessEqual;

@end
