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
        [Tool showMBProgressHUDText:HUD Message:@"请输入手机号" Time:2 addView:self.view FrameY:100.f];
        return;
        
    }else if (!([Tool valiMobile:self.accountF.text] == nil)) {
        
        [Tool showMBProgressHUDText:HUD Message:@"请输入正确的手机号" Time:2 addView:self.view FrameY:100.f];
        return;
    }
    //计算倒计时时间
    [self countReaseTime];
    __weak __typeof(HUD) weakHUD = HUD;
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_accountF.text zone:@"86"  result:^(NSError *error) {
        
        if (!error)
        {
            [Tool showMBProgressHUDText:weakHUD Message:@"验证码发送成功" Time:2 addView:self.view FrameY:100.f];
        }
        else
        {
            [Tool showMBProgressHUDText:weakHUD Message:@"验证码发送失败" Time:2 addView:self.view FrameY:100.f];
        }
    }];
}

- (IBAction)loginAction {
    [self.view endEditing:YES];
    [_passwordF resignFirstResponder];
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
    //审核使用
    if ([_accountF.text isEqualToString:@"15501079050"] && [_passwordF.text isEqualToString:@"1111"]) {
        //直接通过
        [UserConfig sharedInstance].logined = YES;
        NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
        [defaultUser setObject:self.accountF.text forKey:@"accountNum"];
        [defaultUser synchronize];
        [UserConfig sharedInstance].accountNum = self.accountF.text;
        //请求积分
        [[IntegralTool shareTool] requestIntegral];
        
        if ([self.navigationController popViewControllerAnimated:YES]) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        return;
    }
    
    __weak __typeof(HUD) weakHUD = HUD;
    __weak __typeof(self) weakSelf = self;
    [SMSSDK commitVerificationCode:_passwordF.text phoneNumber:_accountF.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            [UserConfig sharedInstance].logined = YES;
            NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
            [defaultUser setObject:weakSelf.accountF.text forKey:@"accountNum"];
            [defaultUser synchronize];
            [UserConfig sharedInstance].accountNum = self.accountF.text;
            //请求积分
            [[IntegralTool shareTool] requestIntegral];
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotication object:nil];
            if ([self.navigationController popViewControllerAnimated:YES]) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }
        else
        {
            [Tool showMBProgressHUDText:weakHUD Message:@"您输入验证码不正确" Time:2 addView:self.view FrameY:100.f];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:true];
}

#pragma mark--倒计时
- (void)countReaseTime
{
    __block NSInteger second = 60;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                [weakSelf.getCodeBtn setTitle:@"验证码" forState:UIControlStateNormal];
                dispatch_cancel(timer);
            } else {
                [weakSelf.getCodeBtn setTitle:[NSString stringWithFormat:@"%ld s",second] forState:UIControlStateNormal];
                second--;
            }
        });
    });
    dispatch_resume(timer);
}

@end
