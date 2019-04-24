//
//  SetUpVC.m
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import "SetUpVC.h"

@interface SetUpVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIView *headerView;
@end

@implementation SetUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]init];
    [_dataArr addObject:@[@{@"name":@"我的积分",@"content":@"200"}]];
    [_dataArr addObject:@[@{@"name":@"隐私协议",@"content":@""},@{@"name":@"服务条款",@"content":@""},@{@"name":@"关于",@"content":@""}]];
    _tabelView.tableHeaderView = self.headerView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140)];
        [_headerView setBackgroundColor:[UIColor whiteColor]];
        UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-75/2, 20, 75, 75)];
        [headerImageView setImage:[UIImage imageNamed:@"headerImage_icon"]];
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [headerImageView addGestureRecognizer:ges];
        [_headerView addSubview:headerImageView];
        
        UILabel *iphoneNum = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerImageView.frame)+10, CGRectGetWidth(_headerView.frame), 30)];
        [iphoneNum setText:[NSString stringWithFormat:@"手机号：%@",[UserConfig sharedInstance].accountNum]];
        [iphoneNum setTextAlignment:NSTextAlignmentCenter];
        [iphoneNum setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
//        [iphoneNum setBackgroundColor:[UIColor redColor]];
        [iphoneNum setFont:[UIFont systemFontOfSize:14]];
        [_headerView addSubview:iphoneNum];
    }
    return _headerView;
}
#pragma mark--UITableViewDelegate/UItableViewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tmpArr = _dataArr[section];
    return tmpArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tmpArr = _dataArr[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifer"];
    UILabel *contendL;
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifer"];
        contendL = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-47, 0, 100, 44)];
        [contendL setTextColor:[UIColor darkGrayColor]];
        [contendL setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:contendL];
    }
    if (indexPath.section!=0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *tmpStr = [tmpArr[indexPath.row]objectForKey:@"name"];
    [cell.textLabel setText:tmpStr];
    [contendL setText:[tmpArr[indexPath.row]objectForKey:@"content"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _dataArr.count-1) {
        return 90;
    }
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 90)];
    UIButton *logotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logotBtn.frame = CGRectMake(20, footerView.bounds.size.height-55, footerView.bounds.size.width-40, 49);
    [logotBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logotBtn setBackgroundColor:[UIColor colorWithRed:199/255.0 green:43/255.0 blue:82/255.0 alpha:1.0]];
    [logotBtn addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
    [logotBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [footerView addSubview:logotBtn];
    if (section == _dataArr.count-1) {
        return footerView;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark--修改头像
-(void)tapAction:(UIGestureRecognizer *)ges
{
    
}
#pragma mark--登出登录
- (void)logoutAction:(UIButton *)btn
{
    [UserConfig sharedInstance].logined = NO;
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"accountNum"];
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
