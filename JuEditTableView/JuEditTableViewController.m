//
//  JuEditTableViewController.m
//  JuEditTableView
//
//  Created by Juvid on 2016/11/1.
//  Copyright © 2016年 Juvid. All rights reserved.
//

#import "JuEditTableViewController.h"
#import "JuEditTableView.h"
#import "EditTableViewCell.h"
#import "UIView+StringFrame.h"
@interface JuEditTableViewController ()<JuTableViewDataSource>

@end

@implementation JuEditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"自定义侧滑";
//        NSArray *items=@[@"编辑",@"删除"];
//    NSMutableArray *arrItemView=[NSMutableArray array];
//    for (int i=0; i<items.count; i++) {
//        JuTableRowAction *btnItems=[JuTableRowAction rowActionWithTitle:items[i]  handler:^(JuTableRowAction *action, NSIndexPath *indexPath) {
//            NSLog(@"当前行 %@ %@",action,indexPath);
//        }];
//        btnItems.ju_itemWidth=120;
//        if (i==1) {
//            btnItems.backgroundColor=[UIColor redColor];
//        }else{
//            btnItems.backgroundColor=[UIColor orangeColor];
//        }
//        [arrItemView addObject:btnItems];
//    }
//    JuEditTableView *table=(JuEditTableView *)self.tableView;
//    table.ju_leftRowAction=arrItemView;
    
     [self.tableView registerNib:[UINib nibWithNibName:@"EditTableViewCell" bundle:nil] forCellReuseIdentifier:@"EditTableViewCell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditTableViewCell"];
    return cell;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 28;
}
-(void)dealloc{
    ;
}

-(BOOL)juTableView:(JuEditTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row>25){
        return NO;
    }
    return YES;
}
- (NSArray<JuTableRowAction *> *)juTableView:(JuEditTableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"初始化");
    NSArray *items=@[@"更多",@"编辑",@"删除"];
    NSArray *colors=@[[UIColor brownColor],[UIColor orangeColor],[UIColor redColor]];
    NSMutableArray *arrItemView=[NSMutableArray array];
    for (int i=0; i<items.count; i++) {
        JuTableRowAction *btnItems=[JuTableRowAction rowActionWithTitle:items[i]  handler:^(JuTableRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"当前行 %@ %@",action,indexPath);
        }];
        if (i==0) {
            btnItems.ju_itemWidth=100;
        }
        btnItems.backgroundColor=colors[i];
        [arrItemView addObject:btnItems];
    }
    return  arrItemView;

}
- (NSArray<JuTableRowAction *> *)juTableView:(JuEditTableView *)tableView editLeftActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items=@[@"标记已读"];
    if (indexPath.row>7) {
        items=@[@"标记已读",@"置顶"];
    }
    NSMutableArray *arrItemView=[NSMutableArray array];
    for (int i=0; i<items.count; i++) {
        JuTableRowAction *btnItems=[JuTableRowAction rowActionWithTitle:items[i]  handler:^(JuTableRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"当前行 %@ %@",action,indexPath);
        }];
        if(i==0){
            btnItems.backgroundColor=[UIColor blueColor];
        }else{
             btnItems.backgroundColor=[UIColor purpleColor];
        }
        [arrItemView addObject:btnItems];
    }
    return  arrItemView;
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"停止");
}
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here, for example:
    // Create the next view controller.
//    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
