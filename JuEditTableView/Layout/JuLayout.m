//
//  JuLayout.m
//  testBlock
//
//  Created by Juvid on 16/7/17.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuLayout.h"
#import "UIView+JuLayout.h"

@implementation JuLayout
-(id)init{
    self=[super init];
    if (self) {
        self.juMulti=1;
        _prioritys=UILayoutPriorityRequired;
    }
    return self;
}
/**
 *  @author Juvid, 16-07-18 09:07:29
 *
 *  添加约束
 *
 *  @param juLayout 约束属性（对象）
 *
 *  @return 约束
 */
-(NSLayoutConstraint *)juAddConstraint{
     if (!_juView1.superview) return nil;
    _juView1.translatesAutoresizingMaskIntoConstraints=NO;
    UIView *toItem=_juView2;
    UIView *ju_View=_juView1.superview;
    CGFloat constant=_juConstant;
    if (self.juAttr1==NSLayoutAttributeWidth||_juAttr1==NSLayoutAttributeHeight) {
        if (!toItem) {
            if (constant==0) {///< 等于0时约束等于父view
                toItem=_juView1.superview;
            }else{///< 自己加约束
                ju_View=_juView1;
            }
        }
        else if([toItem isEqual:_juView1]){///< 长宽比例时
            ju_View=_juView1;
        }
    }else{
        if (!toItem) {
            toItem=_juView1.superview;
        }
    }
    NSLayoutConstraint *layoutConstraint=[NSLayoutConstraint constraintWithItem:_juView1 attribute:_juAttr1 relatedBy:_juRelation toItem:toItem attribute:_juAttr2 multiplier:_juMulti constant:constant];
    layoutConstraint.priority=_prioritys;
    layoutConstraint.juLayType=_juLayoutType;
    
    [_juView1 juCompareSameCons:layoutConstraint];
    
    if (!_juView1.ju_Constraints) _juView1.ju_Constraints=[NSMutableArray array];
    [_juView1.ju_Constraints addObject:layoutConstraint];
    
    [ju_View addConstraint:layoutConstraint];
    
    return layoutConstraint;
}
/***************************************************************/

-(void)setJuConstant:(CGFloat)juConstant{
    _juConstant=juConstant*(_isMinus?-1:1);
}
-(void)setJuLayoutType:(JuLayoutType)juLayoutType{
    _juLayoutType=juLayoutType;
    if (juLayoutType==JuLayoutAspectWH) {
        _juView2=_juView1;
    }
}
/***=====================添加过程约束==============================*/

-(JuLayout *(^)(CGFloat  prioritys))priority{
    return ^JuLayout* (CGFloat  prioritys){
        _prioritys=prioritys;
        return self;
    };
}
-(JuLayout *(^)(CGFloat  mulits))multi{
    return ^JuLayout* (CGFloat  mulits){
        _juMulti=mulits;
        return self;
    };
}
-(JuLayout *(^)(UIView * toItem))toView{
    return ^JuLayout* (UIView * toItem){///< block实现返回block变量
        _juView2=toItem;
        return self;///< block返回值
    };
}

/**======================最终生成约束=============================**/

-(NSLayoutConstraint *(^)(CGFloat constion))equal{
    return ^NSLayoutConstraint* (CGFloat constion){
         _juRelation=NSLayoutRelationEqual;
        self.juConstant=constion;
        return  [self juAddConstraint];
    };
}
-(NSLayoutConstraint *(^)(CGFloat constion))greaterEqual{
    return ^NSLayoutConstraint* (CGFloat constion){
         _juRelation=NSLayoutRelationGreaterThanOrEqual;
        self.juConstant=constion;
        return [self juAddConstraint];
    };
}
-(NSLayoutConstraint *(^)(CGFloat constion))lessEqual{
    return ^NSLayoutConstraint* (CGFloat constion){
         _juRelation=NSLayoutRelationLessThanOrEqual;
        self.juConstant=constion;
        return [self juAddConstraint];
    };
}

@end
