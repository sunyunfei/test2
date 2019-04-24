//
//  RootNavigationController.m
//  iSEE
//
//  Created by 孙云飞 on 2019/4/11.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
  
  //返回按钮
  [self.navigationBar setTintColor:[UIColor whiteColor]];
  
}

//去掉文字，只显示图片
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
  viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc ]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
  [super pushViewController:viewController animated:animated];
}

@end
