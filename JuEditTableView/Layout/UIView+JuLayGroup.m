//
//  UIView+JuLayoutFrame.m
//  JuLayout
//
//  Created by Juvid on 16/7/17.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "UIView+JuLayGroup.h"

@implementation UIView(JuLayGroup)
-(void(^)(UIView *view))juOriginEqual{
    return ^(UIView *view){
        self.juLead.toView(view).equal(0);
        self.juTrail.toView(view).equal(0);
    };
}
-(void(^)(UIView *view))juSizeEqual{
    return ^(UIView *view){
        self.juWidth.toView(view).equal(0);
        self.juHeight.toView(view).equal(0);
    };
}
-(void(^)(UIView *view))juFrameEqual{
    return ^(UIView *view){
        self.juOriginEqual(view);
        self.juSizeEqual(view);
    };
}

-(void(^)(CGPoint origin))juOrigin{
    return ^(CGPoint origin){
        if(origin.x>0) {
             self.juLead.equal(origin.x);
        }else if(origin.x<0){
             self.juTrail.equal(-origin.x);
        }else{
            self.juCenterX.equal(0);
        }
        if(origin.y>0) {
            self.juTop.equal(origin.y);
        }else if(origin.y<0){
             self.juBottom.equal(-origin.y);
        }else{
            self.juCenterY.equal(0);
        }
    };
}
-(void(^)(CGSize size))juSize{
    return ^(CGSize size){
        self.juWidth.equal(size.width);
        self.juHeight.equal(size.height);
    };
}
-(void(^)(CGRect frame))juFrame{
    return ^(CGRect frame){
        self.juOrigin(frame.origin);
        self.juSize(frame.size);
    };
}
-(void(^)(UIEdgeInsets edge))juEdge{
    return ^(UIEdgeInsets edge){
        self.juEdgeTo(edge,nil);
    };
}
-(void(^)(UIEdgeInsets edge,UIView *view))juEdgeTo{
    return ^(UIEdgeInsets edge,UIView *view){
        self.juLead.toView(view).equal(edge.left);
        self.juTrail.toView(view).equal(edge.right);
        self.juTop.toView(view).equal(edge.top);
        self.juBottom.toView(view).equal(edge.bottom);
    };
}

-(void(^)(JuLayEdgeHeight juEdgeH))juEdgeH{
    return ^(JuLayEdgeHeight juEdgeH){
        self.juEdgeHTo(juEdgeH,nil);
    };
}

-(void(^)(JuLayEdgeHeight juEdgeH,UIView *view))juEdgeHTo{
    return ^(JuLayEdgeHeight juEdgeH,UIView *view){
        self.juLead.toView(view).equal(juEdgeH.lead);
        self.juTrail.toView(view).equal(juEdgeH.trail);
        if(juEdgeH.top>0) {
             self.juTop.toView(view).equal(juEdgeH.top);
        }else if(juEdgeH.top==0){
             self.juCenterY.toView(view).equal(juEdgeH.top);
        }else{
             self.juBottom.toView(view).equal(-juEdgeH.top);
        }
        if(juEdgeH.height>0) {
             self.juHeight.toView(view).equal(juEdgeH.height);
        }
       
    };
    
}
-(void(^)(JuLayEdgeWidth juEdgeW))juEdgeW{
    return ^(JuLayEdgeWidth juEdgeW){
        self.juEdgeWTo(juEdgeW,nil);
    };

}
-(void(^)(JuLayEdgeWidth juEdgeW,UIView *view))juEdgeWTo{
    return ^(JuLayEdgeWidth juEdgeW,UIView *view){
        self.juTop.toView(view).equal(juEdgeW.top);
        self.juBottom.toView(view).equal(juEdgeW.bottom);
        
        if(juEdgeW.lead>0) {
             self.juLead.toView(view).equal(juEdgeW.lead);
        }else if(juEdgeW.lead==0){
             self.juCenterX.toView(view).equal(juEdgeW.lead);
        }else{
             self.juTrail.toView(view).equal(-juEdgeW.lead);
        }
        if(juEdgeW.width>0) {
             self.juWidth.toView(view).equal(juEdgeW.width);
        }
    };
    
}

-(void(^)(JuLayRect juFrame))juAlignX{
    return ^(JuLayRect juFrame){
        self.juAlignXTo(juFrame,nil);
    };

}
-(void(^)(JuLayRect juFrame,UIView *view))juAlignXTo{
    return ^(JuLayRect juFrame,UIView *view){
        if(juFrame.lead>0) {
             self.juLead.toView(view).equal(juFrame.lead);
        }else if(juFrame.lead==0){
             self.juCenterX.toView(view).equal(juFrame.lead);
        }else{
             self.juTrail.toView(view).equal(-juFrame.lead);
        }

        if(view) {
            self.juTopSpace.toView(view).equal(juFrame.top);
        }else{
            self.juTop.toView(view).equal(juFrame.top);
        }
        
        if(juFrame.width>0) {
            self.juWidth.toView(view).equal(juFrame.width);
        }
        if(juFrame.height>0) {
             self.juHeight.toView(view).equal(juFrame.height);
        }
       
    };
    
}
-(void(^)(JuLayRect juFrame))juAlignY{
    return ^(JuLayRect juFrame){
        self.juAlignYTo(juFrame,nil);
    };
}
-(void(^)(JuLayRect juFrame,UIView *view))juAlignYTo{
    return ^(JuLayRect juFrame,UIView *view){
        if(juFrame.top>0) {
            self.juTop.toView(view).equal(juFrame.top);
        }else if(juFrame.top==0){
            self.juCenterY.toView(view).equal(juFrame.lead);
        }else{
            self.juBottom.toView(view).equal(-juFrame.lead);
        }
        
        if(view) {
            self.juLeaSpace.toView(view).equal(juFrame.lead);
        }else{
            self.juLead.toView(view).equal(juFrame.lead);
        }
        
        if(juFrame.width>0) {
            self.juWidth.toView(view).equal(juFrame.width);
        }
        if(juFrame.height>0) {
            self.juHeight.toView(view).equal(juFrame.height);
        }
        
    };
}
@end
