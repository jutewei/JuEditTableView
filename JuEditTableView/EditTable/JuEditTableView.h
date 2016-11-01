//
//  TestTableView.h
//  TestSwift
//
//  Created by Juvid on 2016/10/31.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditTableViewDelegate;
@protocol EditTableViewDataSource;
@class JuTableRowAction;
@interface JuEditTableView : UITableView
@property (nonatomic,assign) id<EditTableViewDelegate> juDelegate;
@property (nonatomic,assign) IBOutlet id<EditTableViewDataSource> juDataSource;
@property (nonatomic,weak)NSIndexPath *ju_editIndexPath;

@property (nonatomic,strong)NSArray<UIView*> *ju_leftRowAction;///< 左边action
@property (nonatomic,strong)NSArray<UIView*> *ju_RightRowAction;///< 右边action

-(BOOL)isCanEdit:(UIView *)subView;
-(NSArray<UIView*>*)ju_leftRowAction:(UIView *)subView;
-(NSArray<UIView*>*)ju_RightRowAction:(UIView *)subView;
//-(NSIndexPath *)juSubView:(UIView *)subview;
-(void)juTableEndEdit;
@end

@protocol EditTableViewDelegate <NSObject>
-(void)JuHideEditCell;
@end

@protocol EditTableViewDataSource <NSObject>

@optional
- (NSArray<JuTableRowAction *> *)juTableView:(JuEditTableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;///< 默认左边
- (NSArray<JuTableRowAction *> *)juTableViewLeft:(JuEditTableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)juTableView:(JuEditTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface JuTableRowAction : UIButton
typedef void(^JuHandler)(JuTableRowAction *action, NSIndexPath *indexPath);
+ (instancetype)rowActionWithTitle:(NSString *)title image:(NSString *)imageName handler:(JuHandler)handler;
+ (instancetype)rowActionWithTitle:(NSString *)title handler:(JuHandler)handler;

@end

