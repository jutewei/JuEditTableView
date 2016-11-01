//
//  TestTableView.h
//  TestSwift
//
//  Created by Juvid on 2016/10/31.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditTableViewDelegate;
@interface JuEditTableView : UITableView
@property (nonatomic,assign) id<EditTableViewDelegate> juDelegate;
@property (nonatomic,weak)NSIndexPath *ju_editIndexPath;

@property (nonatomic,strong)NSArray<UIView*> *ju_leftRowAction;///< 左边action
@property (nonatomic,strong)NSArray<UIView*> *ju_RightRowAction;///< 右边action
-(NSIndexPath *)juSubView:(UIView *)subview;
-(void)juTableEndEdit;
@end
@protocol EditTableViewDelegate <NSObject>

-(void)JuHideEditCell;

@end


@interface JuTableRowAction : UIButton
typedef void(^JuHandler)(JuTableRowAction *action, NSIndexPath *indexPath);
+ (instancetype)rowActionWithTitle:(NSString *)title image:(NSString *)imageName handler:(JuHandler)handler;
+ (instancetype)rowActionWithTitle:(NSString *)title handler:(JuHandler)handler;

@end

