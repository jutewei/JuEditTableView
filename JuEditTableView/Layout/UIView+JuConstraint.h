//
//  NSObject+JuConstraint.h
//  JuLayout
//
//  Created by Juvid on 16/7/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,JuLayoutType){
    JuLayoutLead     = 0,///< 左约束
    JuLayoutTrail    = 1,///< 右约束
    JuLayoutCenterX  = 2,///< x中间约束
    
    JuLayoutTop      = 3,///< 顶端约束（包括baseLine）
    JuLayoutBottom   = 4,///< 底端约束
    JuLayoutCenterY  = 5,///< y中间约束（包括baseLine）
    
    JuLayoutWidth    = 6,///< 宽度约束
    JuLayoutHeight   = 7,///< 高度约束
    JuLayoutAspectWH = 8,///< 宽度高度比例约束
};///<三个同时存在并且优先级一样就会冲突

@interface UIView (JuConstraint)
@property (nonatomic,strong) NSMutableArray *ju_Constraints;///< 全部约束
@property (nonatomic,assign) UILayoutPriority ju_Priority;///< 全部约束
/**
 *  @author Juvid, 16-07-20 10:07:06
 *
 *  比较相同的约束并一车
 *
 *  @param currentCons 当前添加约束
 */
-(void)juCompareSameCons:(NSLayoutConstraint *)currentCons;

-(NSLayoutConstraint *)ju_Lead;///< 左边约束
-(NSLayoutConstraint *)ju_Trail;///< 右边约束
-(NSLayoutConstraint *)ju_Top;///< 顶端约束
-(NSLayoutConstraint *)ju_Bottom;///< 低调约束
-(NSLayoutConstraint *)ju_CenterX;///< 横中
-(NSLayoutConstraint *)ju_CenterY;///< 竖中
-(NSLayoutConstraint *)ju_Width;///< 宽度
-(NSLayoutConstraint *)ju_Height;///< 高度
-(NSLayoutConstraint *)ju_AspectWH;///< 宽高比

-(UIView *)ju_PryHigh;///< 750
-(UIView *)ju_PryLow;///< 250
-(UIView *)ju_PryLevel;///< 50
-(UIView *(^)(float priority))ju_PryEqual;///< 自定义优先级

@end

@interface NSLayoutConstraint (JuConstraint)
@property (nonatomic) JuLayoutType juLayType;
@end