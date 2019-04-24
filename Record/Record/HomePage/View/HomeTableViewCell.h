//
//  TableViewCell.h
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *iphoneNumL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UITextView *cntentL;
@property (weak, nonatomic) IBOutlet UIView *subsViews;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
- (IBAction)clickPraiseBtn:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END