//
//  UILabel+StringFrame.h
//  XYLEPlay
//
//  Created by Juvid on 15/6/30.
//  Copyright (c) 2015年 XYGAME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Payload)

@property(nonatomic,strong)id payloadObject;
@property  NSInteger payloadSelect;
@property (nonatomic) CGFloat ju_itemWidth;
@end

@interface UILabel (StringFrame)
- (CGSize)boundingRectWithSize:(CGFloat)width;
-(CGFloat)boundingWidth:(CGFloat)height;
-(CGFloat)boundingHeight:(CGFloat)width;
@end

@interface UITextField (StringFrame)
- (CGSize)boundingRectWithSize:(CGFloat)width;
-(CGFloat)boundingWidth:(CGFloat)width;
-(CGFloat)boundingHeight:(CGFloat)width;
@end

@interface UIButton (StringFrame)
- (CGSize)boundingRectWithSize:(CGFloat)width;
-(CGFloat)boundingWidth:(CGFloat)width;
-(CGFloat)boundingHeight:(CGFloat)width;
@end
