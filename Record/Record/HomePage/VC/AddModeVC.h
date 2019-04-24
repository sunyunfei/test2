//
//  AddModeVC.h
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import "RootViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddModeVC : RootViewController
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *contentTF;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderL;
- (IBAction)BadModeAction:(UIButton *)sender;
- (IBAction)submitAction;



@end

NS_ASSUME_NONNULL_END
