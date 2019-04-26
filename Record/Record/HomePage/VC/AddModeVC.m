//
//  AddModeVC.m
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import "AddModeVC.h"

@interface AddModeVC ()<UITextViewDelegate>
{
    MBProgressHUD *HUD;
    NSInteger modetype;
    UIButton *selectedBtn;
}
@end

@implementation AddModeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加心情日记";
    [self addBackItemAndAction];
    _contentView.layer.cornerRadius = 5;
    _contentView.clipsToBounds = YES;
    
}
#pragma mark--UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        if (textView.text.length==0) {
            _placeHolderL.hidden = NO;
        }
        [textView resignFirstResponder];
        return NO;
    }else{
        
        return YES;
    }
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _placeHolderL.hidden = YES;
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        _placeHolderL.hidden = YES;
    }else{
        _placeHolderL.hidden = NO;
    }
    NSString *messageStr;
    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]||[lang isEqualToString:@"ja-JP"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 2000) {
                [Tool showMBProgressHUDText:HUD Message:@"不能超过2000汉字哦" Time:2.0 addView:self.view FrameY:0.f];
                textView.text = [toBeString substringToIndex:2000];
            }else{
                
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > 500) {
            textView.text = [toBeString substringToIndex:500];
        }
    }
    _contentTF.text = textView.text;
}


- (IBAction)BadModeAction:(UIButton *)sender {
    if (selectedBtn) {
        selectedBtn.selected = NO;
    }
    selectedBtn = sender;
    modetype = sender.tag-100;
    sender.selected = YES;
    switch (sender.tag) {
        case 100://不好的心情
            
            break;
        case 101://一般
            
            break;
        case 102://调皮
            
            break;
        case 103://开心
            
            break;
            
        default:
            break;
    }
}

- (IBAction)submitAction {
    if (_contentTF.text.length==0) {
        [Tool showMBProgressHUDText:HUD Message:@"说点什么吧~" Time:2.0 addView:self.view FrameY:0.0];
        return;
    }
    __weak typeof(HUD)weakHud = HUD;
    BmobObject*HomeContent = [BmobObject objectWithClassName:BmobHomeContentTab];
    [HomeContent setObject:_contentTF.text forKey:@"content"];
    [HomeContent setObject:[NSNumber numberWithInteger:modetype] forKey:@"type"];
    [HomeContent setObject:[NSNumber numberWithInteger:0] forKey:@"praise"];
    [HomeContent setObject:[UserConfig sharedInstance].accountNum forKey:@"mobile"];
    NSDate *nowdate = [NSDate new];
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [formater stringFromDate:nowdate];
    [HomeContent setObject:dateStr forKey:@"date"];
    //异步保存到服务器
    [HomeContent saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //创建成功后会返回objectId，updatedAt，createdAt等信息
            [Tool showMBProgressHUDText:weakHud Message:@"发布成功~" Time:2.0 addView:self.view FrameY:0.0];
            if (self.AddModeVCBlock) {
                self.AddModeVCBlock();
            }
            [self performSelector:@selector(backBefore) withObject:self afterDelay:1.4];
        } else if (error){
            //发生错误后的动作
            NSLog(@"%@",error);
        } else {
            NSLog(@"Unknow error");
        }
    }];
}
@end
