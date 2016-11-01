//
//  UILabel+StringFrame.m
//  XYLEPlay
//
//  Created by Juvid on 15/6/30.
//  Copyright (c) 2015年 XYGAME. All rights reserved.
//

#import "UIView+StringFrame.h"
#import <objc/runtime.h>
@implementation NSObject (Payload)

static const char* payload="nsobject.payload";
static const void *PayloadSelect = &PayloadSelect;
-(id)payloadObject{
    return objc_getAssociatedObject(self, &payload);
}
-(void)setPayloadObject:(id)payloadObject{
    objc_setAssociatedObject(self, &payload, payloadObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger)payloadSelect
{
    return [objc_getAssociatedObject(self, PayloadSelect) intValue];
}
-(void)setPayloadSelect:(NSInteger)payloadSelect
{
    NSNumber *number = [[NSNumber alloc] initWithInteger:payloadSelect];
    objc_setAssociatedObject(self, PayloadSelect, number, OBJC_ASSOCIATION_COPY);
}
@end
@implementation UILabel (StringFrame)
- (CGSize)boundingRectWithSize:(CGFloat)width {
    return [self boundingRectWithSize:width isWidth:YES];
}
- (CGSize)boundingRectWithSize:(CGFloat)width isWidth:(BOOL)isWid{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    if (self.attributedText.length>0) {
        NSRange range = NSMakeRange(0, self.attributedText.length);
        NSDictionary *dic = [self.attributedText attributesAtIndex:0 effectiveRange:&range];   // 获取该段
        if (dic)[attributes setDictionary:dic];
    }
    [attributes setValue:self.font forKey:NSFontAttributeName];
    CGSize sizeText=CGSizeMake(isWid?width:MAXFLOAT, isWid?MAXFLOAT:width);

    CGSize retSize = [self.text boundingRectWithSize:sizeText
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attributes
                                             context:nil].size;
    
    return retSize;
}


-(CGFloat)boundingWidth:(CGFloat)height{
    return [self boundingRectWithSize:height isWidth:NO].width;
}
-(CGFloat)boundingHeight:(CGFloat)width{
    return [self boundingRectWithSize:width].height;
}
@end


@implementation UIButton (StringFrame)

- (CGSize)boundingRectWithSize:(CGFloat)width
{
    NSDictionary *attribute = @{NSFontAttributeName: self.titleLabel.font};
    NSString *title=self.currentAttributedTitle?self.currentAttributedTitle.string:self.currentTitle;
    CGSize retSize = [title  boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
-(CGFloat)boundingWidth:(CGFloat)width{
    return [self boundingRectWithSize:width].width;
}
-(CGFloat)boundingHeight:(CGFloat)width{
    return [self boundingRectWithSize:width].height;
}
@end

@implementation UITextField (StringFrame)

- (CGSize)boundingRectWithSize:(CGFloat)width
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
-(CGFloat)boundingWidth:(CGFloat)width{
    return [self boundingRectWithSize:width].width;
}
-(CGFloat)boundingHeight:(CGFloat)width{
    return [self boundingRectWithSize:width].height;
}
@end


/*
 *
 NSStringDrawingTruncatesLastVisibleLine：
 
 如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。如果没有指定NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略。
 
 NSStringDrawingUsesLineFragmentOrigin：
 
 绘制文本时使用 line fragement origin 而不是 baseline origin。
 
 The origin specified when drawing the string is the line fragment origin and not the baseline origin.
 
 NSStringDrawingUsesFontLeading：
 
 计算行高时使用行距。（译者注：字体大小+行间距=行距）
 
 NSStringDrawingUsesDeviceMetrics：
 
 计算布局时使用图元字形（而不是印刷字体）。
 
 Use the image glyph bounds (instead of the typographic bounds) when computing layout.
 */

