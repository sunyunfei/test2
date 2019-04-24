//
//  RootViewController.m
//  Record
//
//  Created by 涂欢 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 *  添加右侧返回按钮
 */
- (void)addBackItemAndAction
{
    UIBarButtonItem * leftItem = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
        leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBefore)];
    } else {
        leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_white"] style:UIBarButtonItemStyleDone target:self action:@selector(backBefore)];
    }
    self.navigationItem.leftBarButtonItem =leftItem;
    
    
    //    [self addCloseItem];
    
    //自定义leftbarbuttonitem会导致右划手势失效.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }
}

- (void)backBefore
{
    if ([[self.navigationController.viewControllers[0] class] isSubclassOfClass:[self class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
