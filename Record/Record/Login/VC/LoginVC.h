//
//  LoginVC.h
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountF;
@property (weak, nonatomic) IBOutlet UITextField *passwordF;
- (IBAction)getCodeAction;
- (IBAction)loginAction;
- (IBAction)backAction;

@end

NS_ASSUME_NONNULL_END
