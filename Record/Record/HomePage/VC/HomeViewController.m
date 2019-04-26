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
#import "HomeContentModel.h"
#import "LookModeDetailVC.h"
static NSString *HomeTableViewCell_identifer = @"HomeTableViewCell_identifer";
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableVew;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc]init];
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *account = [defaultUser objectForKey:@"accountNum"];
    if (!account||account.length==0) {
        [self presentLoginVC];
    }else{
        [UserConfig sharedInstance].logined = YES;
        [UserConfig sharedInstance].accountNum = account;
    }
    [self.view addSubview:self.tableView];
    
    //请求网络数据
    __weak HomeViewController *homepageVC = self;
    self.tableVew.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [homepageVC getRequestData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [homepageVC getRequestData:NO];
    }];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-75, [UIScreen mainScreen].bounds.size.height-120, 60, 60);
    [addBtn setImage:[UIImage imageNamed:@"addMode_icon"] forState:UIControlStateNormal];
    addBtn.alpha = 0.8;
    [addBtn addTarget:self action:@selector(addModeaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    [homepageVC getRequestData:YES];
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
    return _dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeTableViewCell_identifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentModel = _dataArr[indexPath.section];
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
    LookModeDetailVC *detailVC = [[LookModeDetailVC alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.contentModel = _dataArr[indexPath.section];
    [self.navigationController pushViewController:detailVC animated:YES];
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
    addVC.AddModeVCBlock = ^{
        [self getRequestData:YES];
    };
    [self.navigationController pushViewController:addVC animated:YES];
}
#pragma mark--获取数据
- (void)getRequestData:(BOOL)isHeader
{
    __weak typeof(HomeViewController)*homeVC = self;
    BmobQuery*bquery = [BmobQuery queryWithClassName:BmobHomeContentTab];
    bquery.limit = 10;
    if (isHeader) {
        [_dataArr removeAllObjects];
    }
    if (_dataArr.count>=10) {
        bquery.skip = _dataArr.count;
    }
    //查找GameScore表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            HomeContentModel *contentModel = [[HomeContentModel alloc]init];
            contentModel.objectId = [obj objectId];
            contentModel.mobile = [obj objectForKey:@"mobile"];
            contentModel.content = [obj objectForKey:@"content"];
            contentModel.type = [[obj objectForKey:@"type"]integerValue];
            contentModel.date = [obj objectForKey:@"date"];
            contentModel.praise = [[obj objectForKey:@"praise"]integerValue];
            [homeVC.dataArr addObject:contentModel];
        }
        [homeVC.tableVew reloadData];
        if (array.count<10) {
            homeVC.tableVew.mj_footer.hidden = YES;
        }
        [homeVC.tableVew.mj_footer endRefreshing];
        [homeVC.tableVew.mj_header endRefreshing];
    }];
}
@end
