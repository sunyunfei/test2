//
//  AgreementViewController.m
//  Record
//
//  Created by 孙云飞 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()
@property (strong, nonatomic)UIWebView *webView;

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackItemAndAction];
    self.webView = [[UIWebView alloc]init];
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    
    if (self.type == PRIVATE) {
        self.title = @"隐私协议";
        //https://blog.csdn.net/github_30943901/article/details/89530813
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://blog.csdn.net/github_30943901/article/details/89530813"]]];
    }else{
        self.title = @"服务条款";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://blog.csdn.net/github_30943901/article/details/89530896"]]];
    }
}



@end
