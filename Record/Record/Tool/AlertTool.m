//
//  AlertTool.m
//  iSEE
//
//  Created by 孙云飞 on 2019/4/24.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AlertTool.h"
#import <UIKit/UIKit.h>
@implementation AlertTool
//正常展示alert
+ (void)showALertTitle:(NSString *)title content:(NSString *)content showType:(showType)type sure:(void(^)(void))sureBlock cancel:(void(^)(void))cancelBlock{
  
  dispatch_async(dispatch_get_main_queue(), ^{//确保在主线程
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    
    if (type == twoButton) {
      [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelBlock();
      }]];
    }
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      sureBlock();
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:true completion:nil];
    
  });
}

@end
