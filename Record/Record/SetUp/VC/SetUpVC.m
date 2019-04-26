//
//  SetUpVC.m
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import "SetUpVC.h"
#import "IAPViewController.h"
#import "AgreementViewController.h"
#import "AboutViewController.h"
#import "LoginVC.h"
@interface SetUpVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic,weak)UILabel *iphoneNum;
@end

@implementation SetUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]init];
    _tabelView.tableHeaderView = self.headerView;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginsuccess) name:LoginSuccessNotication object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *account = [defaultUser objectForKey:@"accountNum"];
    if (!account||account.length==0) {
        [self presentLoginVC];
    }else{
        [UserConfig sharedInstance].logined = YES;
        [UserConfig sharedInstance].accountNum = account;
        self.iphoneNum.text = account;
    }
    
    if (_dataArr.count > 0) {
        [_dataArr removeAllObjects];
    }
    NSMutableDictionary *scoreMuDict = [[NSMutableDictionary alloc]initWithDictionary:@{@"name":@"我的积分",@"content":[NSString stringWithFormat:@"%ld",(long)[IntegralTool shareTool].integral]}];
    [_dataArr addObject:@[scoreMuDict]];
    [_dataArr addObject:@[@{@"name":@"隐私协议",@"content":@""},@{@"name":@"服务条款",@"content":@""},@{@"name":@"关于",@"content":@""}]];
    [_tabelView reloadData];
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
        self.iphoneNum = iphoneNum;
    }
    return _headerView;
}

//登录
- (void)presentLoginVC
{
    UIStoryboard * story =
    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginVC *logVC = [story instantiateViewControllerWithIdentifier:@"LoginVC"];
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    /* viewController.presentedViewController只有present才有值，push的时候为nil
     */
    
    //防止重复弹
    if ([viewController.presentedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (id)viewController.presentedViewController;
        if ([navigation.topViewController isKindOfClass:[LoginVC class]]) {
            return;
        }
    }
    if (viewController.presentedViewController) {
        //要先dismiss结束后才能重新present否则会出现Warning: Attempt to present <UINavigationController: 0x7fdd22262800> on <UITabBarController: 0x7fdd21c33a60> whose view is not in the window hierarchy!就会present不出来登录页面
        [viewController.presentedViewController dismissViewControllerAnimated:false completion:^{
            [viewController presentViewController:logVC animated:true completion:nil];
        }];
    }else {
        [viewController presentViewController:logVC animated:true completion:nil];
    }
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"identifer"];
        contendL = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-47, 0, 100, 44)];
        [contendL setTextColor:[UIColor darkGrayColor]];
        [contendL setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:contendL];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *tmpStr = [tmpArr[indexPath.row]objectForKey:@"name"];
    [cell.textLabel setText:tmpStr];
    cell.detailTextLabel.text = [tmpArr[indexPath.row]objectForKey:@"content"];
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
    
    if (indexPath.section ==0 && indexPath.row == 0) {
        
        IAPViewController *vc = [[IAPViewController alloc]init];
        vc.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:vc animated:true];
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 1 || indexPath.row == 0) {
            
            AgreementViewController *vc = [[AgreementViewController alloc]init];
            vc.type = indexPath.row;
            vc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:vc animated:true];
        }else{
            
            //关于
            AboutViewController *vc = [[AboutViewController alloc]init];
            vc.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:vc animated:true];
        }
    }
}
#pragma mark--修改头像
-(void)tapAction:(UIGestureRecognizer *)ges
{
    
}
#pragma mark--登出登录
- (void)logoutAction:(UIButton *)btn
{
    [UserConfig sharedInstance].logined = NO;
    [UserConfig cutoutMessage];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"accountNum"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"integral"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isIntegralAlert"];
    //弹出登录
    [self presentLoginVC];
}
- (void)loginsuccess
{
    NSMutableDictionary *scoreDict = _dataArr[0][0];
    [scoreDict setValue:[NSString stringWithFormat:@"%ld",[IntegralTool shareTool].integral] forKey:@"content"];
    [_tabelView reloadData];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
