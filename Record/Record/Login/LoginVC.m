//
//  LoginVC.m
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import "LoginVC.h"
#import <SMS_SDK/SMSSDK.h>
@interface LoginVC ()<UITextFieldDelegate>
{
    MBProgressHUD *HUD;
    NSString *requestCode;
}
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_accountF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    requestCode = @"";
}

- (IBAction)getCodeAction {
    //判断手机号
    if ([self.accountF.text isEqualToString:@""]) {
        [Tool showMBProgressHUDText:HUD Message:@"请输入手机号" Time:2 addView:self.view FrameY:0];
        return;
        
    }else if (!([Tool valiMobile:self.accountF.text] == nil)) {
        
        [Tool showMBProgressHUDText:HUD Message:@"请输入正确的手机号" Time:2 addView:self.view FrameY:0];
        return;
    }
    __weak __typeof(HUD) weakHUD = HUD;
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_accountF.text zone:@"86"  result:^(NSError *error) {
        
        if (!error)
        {
            [Tool showMBProgressHUDText:weakHUD Message:@"验证码发送成功" Time:2 addView:self.view FrameY:0];
        }
        else
        {
            [Tool showMBProgressHUDText:weakHUD Message:@"验证码发送失败" Time:2 addView:self.view FrameY:0];
        }
    }];
}

- (IBAction)loginAction {
    if ([self.passwordF.text isEqualToString:@""]){
        [Tool showMBProgressHUDText:HUD Message:@"请输入验证码" Time:2 addView:self.view FrameY:0];
        return;
    }
    //提交验证码
    [self justyPasswordToLogin];
}

- (IBAction)backAction {
    if ([self.navigationController popViewControllerAnimated:YES]) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == _accountF) {
        [_passwordF becomeFirstResponder];
    }else{
        //提交验证码
        [self justyPasswordToLogin];
    }
    return YES;
}
- (void)justyPasswordToLogin
{
    __weak __typeof(HUD) weakHUD = HUD;
    __weak __typeof(self) weakSelf = self;
    [SMSSDK commitVerificationCode:_passwordF.text phoneNumber:_accountF.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            [UserConfig sharedInstance].logined = YES;
            NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
            [defaultUser setObject:weakSelf.accountF.text forKey:@"accountNum"];
            [defaultUser synchronize];
            if ([self.navigationController popViewControllerAnimated:YES]) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }
        else
        {
            [Tool showMBProgressHUDText:weakHUD Message:@"您输入验证码不正确" Time:2 addView:self.view FrameY:0];
        }
    }];
}
@end
