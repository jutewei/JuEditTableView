//
//  UIView+Frame.h
//  YunHK
//
//  Created by Juvid on 14/12/16.
//  Copyright (c) 2014年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JuLayGroup.h"
#import "UIView+StringFrame.h"
@interface UIView (Frame)

- (CGFloat)originX;
- (CGFloat)originY;
- (CGFloat)sizeW;
- (CGFloat)sizeH;
-(void)setOriginX:(CGFloat)originX;
-(void)setOriginY:(CGFloat)originY;
-(void)setSizeW:(CGFloat)sizeW;
-(void)setSizeH:(CGFloat)sizeH;

-(void)removeAllSubviews;//移除所有View
-(UIBarButtonItem*)barButtonItem;

@end
