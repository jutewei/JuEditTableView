//
//  NSObject+JuConstraint.m
//  JuConsout
//
//  Created by Juvid on 16/7/19.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "UIView+JuConstraint.h"
#import <objc/runtime.h>
@implementation UIView (JuConstraint)
-(void)setJu_Constraints:(NSMutableArray *)ju_Constraints{
    objc_setAssociatedObject(self, @selector(ju_Constraints), ju_Constraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSMutableArray *)ju_Constraints{
    return objc_getAssociatedObject(self, @selector(ju_Constraints));
}
-(void)setJu_Priority:(UILayoutPriority )ju_Priority{
     objc_setAssociatedObject(self, @selector(ju_Priority), @(ju_Priority), OBJC_ASSOCIATION_COPY);
}
-(UILayoutPriority)ju_Priority{
     return [objc_getAssociatedObject(self, @selector(ju_Priority)) floatValue];
}
#pragma mark 私有方法

-(void)juCompareSameCons:(NSLayoutConstraint *)currentCons{
    NSLayoutConstraint *lastCons=[self juConstrain:currentCons.juLayType withPry:currentCons.priority];
    if (lastCons) {
        if ([self.superview.constraints containsObject:lastCons]) {
            [self.superview removeConstraint:lastCons];
            [self.ju_Constraints removeObject:lastCons];
        }
        else if([self.constraints containsObject:lastCons]){
            [self removeConstraint:lastCons];
            [self.ju_Constraints removeObject:lastCons];
        }
    }
}
-(NSLayoutConstraint *)juConstrain:(JuLayoutType)juLayType withPry:(UILayoutPriority )priority{
    for (NSLayoutConstraint *lastCons in self.ju_Constraints) {
        if (lastCons.juLayType==juLayType&&lastCons.priority==priority) {
            return lastCons;
        }
    }
    return nil;
}
-(NSLayoutConstraint *)juConstrain:(JuLayoutType)juLayType{
    if (self.ju_Priority==0.00) self.ju_Priority=UILayoutPriorityRequired;
    NSLayoutConstraint *layoutCons=[self juConstrain:juLayType withPry:self.ju_Priority];
    self.ju_Priority=UILayoutPriorityRequired;
    return layoutCons;
}



-(NSLayoutConstraint *)ju_Lead{
    return [self juConstrain:JuLayoutLead];
}
-(NSLayoutConstraint *)ju_Trail{
   return  [self juConstrain:JuLayoutTrail];
}
-(NSLayoutConstraint *)ju_Top{
     return  [self juConstrain:JuLayoutTop];
}
-(NSLayoutConstraint *)ju_Bottom{
    return  [self juConstrain:JuLayoutBottom];
}
-(NSLayoutConstraint *)ju_CenterX{
   return  [self juConstrain:JuLayoutCenterX];
}
-(NSLayoutConstraint *)ju_CenterY{
     return  [self juConstrain:JuLayoutCenterY];
}
-(NSLayoutConstraint *)ju_Width{
    return  [self juConstrain:JuLayoutWidth];
}
-(NSLayoutConstraint *)ju_Height{
    return  [self juConstrain:JuLayoutHeight];
}
-(NSLayoutConstraint *)ju_AspectWH{
    return  [self juConstrain:JuLayoutAspectWH];
}

-(UIView *)ju_PryHigh{
    self.ju_Priority=UILayoutPriorityDefaultHigh;
   return self;
}
-(UIView *)ju_PryLow{
    self.ju_Priority=UILayoutPriorityDefaultLow;
   return self;
}
-(UIView *)ju_PryLevel{
    self.ju_Priority=UILayoutPriorityFittingSizeLevel;
    return self;
}
-(UIView *(^)(float priority))ju_PryEqual{
    return ^UIView *(float priority){
        self.ju_Priority=priority;
       return self;
    };
}
@end

@implementation NSLayoutConstraint (JuConstraint)
-(void)setJuLayType:(JuLayoutType)juLayType{
    objc_setAssociatedObject(self, @selector(juLayType), @(juLayType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(JuLayoutType)juLayType{
    return [objc_getAssociatedObject(self, @selector(juLayType)) integerValue];
}
@end