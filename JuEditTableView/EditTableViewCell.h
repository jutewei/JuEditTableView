//
//  EditTableViewCell.h
//  TestSwift
//
//  Created by Juvid on 2016/11/1.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuEditCellContentView.h"
@interface EditTableViewCell : UITableViewCell{
    
    __weak IBOutlet JuEditCellContentView *ju_contentView;
}

@end
