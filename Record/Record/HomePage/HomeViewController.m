//
//  ViewController.m
//  Record
//
//  Created by 孙云飞 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginVC.h"
@interface HomeViewController ()

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
    }
    
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
@end
