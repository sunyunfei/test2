//
//  TableViewCell.h
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HomeContentModel;
@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *iphoneNumL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UITextView *cntentL;
@property (weak, nonatomic) IBOutlet UIView *subsViews;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIImageView *modeImageView;
@property (weak, nonatomic) IBOutlet UILabel *priseNumL;
@property (nonatomic,strong)NSIndexPath *indexPath;
//刷新
@property (nonatomic,copy)void (^refreshIndexPath)(NSIndexPath *indexPath);
- (IBAction)clickPraiseBtn:(UIButton *)sender;
@property (nonatomic, strong)HomeContentModel *contentModel;
@end

NS_ASSUME_NONNULL_END
