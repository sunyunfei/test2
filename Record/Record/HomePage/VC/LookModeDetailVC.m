//
//  LookModeDetailVC.m
//  Record
//
//  Created by 涂欢 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import "LookModeDetailVC.h"
#import "HomeDetailHeaderView.h"
#import "HomeContentModel.h"
@interface LookModeDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat contentH;
    MBProgressHUD *HUD;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *headerView;
@end

@implementation LookModeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItemAndAction];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.tableView];
    HomeDetailHeaderView *headerView =  [HomeDetailHeaderView viewWithXib];
    headerView.model = _contentModel;
    self.tableView.tableHeaderView = headerView;
    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:_contentModel.content];
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-30, CGFLOAT_MAX) text:attStr];
    contentH = layout.textBoundingSize.height;
    [Tool showMBProgressHUDText:HUD Message:@"积分-1" Time:1.7 addView:self.view FrameY:0.0];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_tableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
    return _tableView;
}
#pragma mark -- uitableViewdelegate/datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return contentH+50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifer"];
    YYTextView *contentT;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifer"];
        contentT = [[YYTextView alloc]initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width-30, contentH+20)];
        [contentT setFont:[UIFont systemFontOfSize:14]];
        [contentT setTextColor:[UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1.0]];
//        contentT.numberOfLines = 0;
        contentT.userInteractionEnabled = NO;
        [cell.contentView addSubview:contentT];
    }
    [contentT setText:_contentModel.content];
    return cell;
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
