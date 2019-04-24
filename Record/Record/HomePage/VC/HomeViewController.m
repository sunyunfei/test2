//
//  ViewController.m
//  Record
//
//  Created by 孙云飞 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginVC.h"
#import "HomeTableViewCell.h"
#import "AddModeVC.h"
static NSString *HomeTableViewCell_identifer = @"HomeTableViewCell_identifer";
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableVew;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *account = [defaultUser objectForKey:@"accountNum"];
    if (!account||account.length==0) {
        [self presentLoginVC];
    }else{
        [UserConfig sharedInstance].logined = YES;
        [UserConfig sharedInstance].accountNum = account;
    }
    [self.view addSubview:self.tableView];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-75, [UIScreen mainScreen].bounds.size.height-120, 60, 60);
    [addBtn setImage:[UIImage imageNamed:@"addMode_icon"] forState:UIControlStateNormal];
    addBtn.alpha = 0.8;
    [addBtn addTarget:self action:@selector(addModeaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
}

- (UITableView *)tableView
{
    if (!_tableVew) {
        _tableVew = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
        _tableVew.delegate = self;
        _tableVew.dataSource = self;
        [_tableVew registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:HomeTableViewCell_identifer];
        _tableVew.estimatedRowHeight = 0;
        _tableVew.estimatedSectionFooterHeight = 0;
        _tableVew.estimatedSectionHeaderHeight = 0;
        _tableVew.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableVew;
}
#pragma mrk--UITableViewdelegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeTableViewCell_identifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
#pragma mark--添加心情
- (void)addModeaction:(UIButton *)btn
{
    AddModeVC *addVC = [[AddModeVC alloc]init];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}
@end