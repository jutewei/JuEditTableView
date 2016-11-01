//
//  UIView+Layout.m
//  testBlock
//
//  Created by Juvid on 16/7/17.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "UIView+JuLayout.h"
//#import "JuLayout.h"
@implementation UIView (JuLayout)

-(JuLayout *)newJuLay:(NSLayoutAttribute)firstAtt withType:(JuLayoutType)layoutType{
    return [self newJuLay:firstAtt secondAtt:firstAtt withType:layoutType];
}
-(JuLayout *)newJuLayMinus:(NSLayoutAttribute)firstAtt withType:(JuLayoutType)layoutType{
    JuLayout *layout=[self newJuLay:firstAtt secondAtt:firstAtt withType:layoutType];
    layout.isMinus=YES;
    return layout;
}
-(JuLayout *)newJuLay:(NSLayoutAttribute)firstAtt secondAtt:(NSLayoutAttribute)secondAtt withType:(JuLayoutType)layoutType{
    JuLayout *layout=[JuLayout new];
    layout.juAttr1=firstAtt;
    layout.juAttr2=secondAtt;
    layout.juView1=self;
    layout.juLayoutType=layoutType;
    return layout;
}
-(JuLayout *)juLead{
    return [self newJuLay:NSLayoutAttributeLeading withType:JuLayoutLead];
}
-(JuLayout *)juTrail{
    return [self newJuLayMinus:NSLayoutAttributeTrailing withType:JuLayoutTrail];
}
-(JuLayout *)juTop{
    return [self newJuLay:NSLayoutAttributeTop withType:JuLayoutTop];
}
-(JuLayout *)juBottom{
    return [self newJuLayMinus:NSLayoutAttributeBottom withType:JuLayoutBottom];
}
-(JuLayout *)juLeaSpace{
    return [self newJuLay:NSLayoutAttributeLeading secondAtt:NSLayoutAttributeTrailing withType:JuLayoutLead];
}
-(JuLayout *)juTraSpace{
    return [self newJuLay:NSLayoutAttributeTrailing secondAtt:NSLayoutAttributeLeading withType:JuLayoutTrail];
}

-(JuLayout *)juTopSpace{
    return [self newJuLay:NSLayoutAttributeTop secondAtt:NSLayoutAttributeBottom withType:JuLayoutTop];
}
-(JuLayout *)juBtmSpace{
    return [self newJuLay:NSLayoutAttributeBottom secondAtt:NSLayoutAttributeTop withType:JuLayoutBottom];
}
-(JuLayout *)juLastLine{
    return [self newJuLay:NSLayoutAttributeLastBaseline withType:JuLayoutBottom];
}

-(JuLayout *)juFirLine{
    return  [self newJuLay:NSLayoutAttributeFirstBaseline withType:JuLayoutTop];
}
-(JuLayout *)juCenterX{
    return [self newJuLay:NSLayoutAttributeCenterX withType:JuLayoutCenterX];
}
-(JuLayout *)juCenterY{
    return [self newJuLay:NSLayoutAttributeCenterY withType:JuLayoutCenterY];
}

-(JuLayout *)juWidth{
    return [self newJuLay:NSLayoutAttributeWidth withType:JuLayoutWidth];
}
-(JuLayout *)juHeight{
    return [self newJuLay:NSLayoutAttributeHeight withType:JuLayoutHeight];
}
-(JuLayout *)juAspectWH{
    return [self newJuLay:NSLayoutAttributeWidth secondAtt:NSLayoutAttributeHeight withType:JuLayoutAspectWH];
}


@end
