//
//  UIView+Frame.m
//  YunHK
//
//  Created by Juvid on 14/12/16.
//  Copyright (c) 2014年 Juvid. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (CGFloat)sizeW
{
    return self.frame.size.width;
}

- (CGFloat)sizeH
{
    return self.frame.size.height;
}
-(void)setOriginX:(CGFloat)originX{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}
-(void)setOriginY:(CGFloat)originY{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}
-(void)setSizeW:(CGFloat)sizeW{
    CGRect frame = self.frame;
    frame.size.width = sizeW;
    self.frame = frame;
}
-(void)setSizeH:(CGFloat)sizeH{
    CGRect frame = self.frame;
    frame.size.height = sizeH;
    self.frame = frame;
}
-(void)removeAllSubviews{
    //    NSLog(@"这是谁  %@",self);
    while (self.subviews.count>0) {
        UIView *subview=self.subviews.firstObject;
        [subview removeFromSuperview];
    }
}
-(UIBarButtonItem*)barButtonItem{
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}
@end
