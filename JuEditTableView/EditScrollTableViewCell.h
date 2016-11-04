//
//  EditScrollTableViewCell.h
//  JuEditTableView
//
//  Created by Juvid on 2016/11/4.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditScrollTableViewCell : UITableViewCell{
    __weak IBOutlet UIScrollView *sh_contentView;
    __weak IBOutlet UIView *sh_vieEdit;
    UITapGestureRecognizer *sh_closeEdit;
}

@end
