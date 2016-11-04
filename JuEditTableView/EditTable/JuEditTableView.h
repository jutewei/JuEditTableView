//
//  TestTableView.h
//  TestSwift
//
//  Created by Juvid on 2016/10/31.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "UIView+tableView.h"
@protocol JuTableViewDataSource;
@class JuTableRowAction;
@interface JuEditTableView : UITableView

@property (nonatomic,assign) IBOutlet id<JuTableViewDataSource> juDataSource;

@property (nonatomic,weak)  NSIndexPath *slideIndexPath;///< 侧滑之前防止多个一起滑动（内部使用）
@property (nonatomic,weak)  NSIndexPath *ju_editIndexPath;///< 当前侧滑出的cell（内部文件类）

@property (nonatomic,copy)  dispatch_block_t juEndEdit;

//@property (nonatomic,copy)NSArray<UIView*> *ju_leftRowAction;///< 左边action
//@property (nonatomic,copy)NSArray<UIView*> *ju_RightRowAction;///< 右边action

-(BOOL)cellCanEdit:(NSIndexPath *)indexPath;
-(NSArray<UIView*>*)juLeftRowAction:(NSIndexPath *)indexPath;
-(NSArray<UIView*>*)juRightRowAction:(NSIndexPath *)indexPath;

@end


@protocol JuTableViewDataSource <NSObject>

@optional

-(NSArray<UIView*>*)juLeftRowActions;///< 左边统一样式
-(NSArray<UIView*>*)juRightRowActions;///< 右边统一样式

- (NSArray<JuTableRowAction *> *)juTableView:(JuEditTableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;///< 默认右边
- (NSArray<JuTableRowAction *> *)juTableView:(JuEditTableView *)tableView editLeftActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)juTableView:(JuEditTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface JuTableRowAction : UIButton
typedef void(^JuHandler)(JuTableRowAction *action, NSIndexPath *indexPath);
+ (instancetype)rowActionWithTitle:(NSString *)title image:(NSString *)imageName handler:(JuHandler)handler;
+ (instancetype)rowActionWithTitle:(NSString *)title handler:(JuHandler)handler;
//@property CGFloat juItemWidth;
@end
