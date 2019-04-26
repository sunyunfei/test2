//
//  TableViewCell.m
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeContentModel.h"
@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.subsViews.layer.cornerRadius = 4;
    self.subsViews.clipsToBounds = YES;

}
- (void)setContentModel:(HomeContentModel *)contentModel
{
    _contentModel = contentModel;
    //手机号
    [self.iphoneNumL setText:[Tool idNumberReplaceSecret:contentModel.mobile]];
    //时间
    [self.timeL setText:_contentModel.date];
    //内容
    [self.cntentL setText:_contentModel.content];
    //点赞
    [self.priseNumL setText:[NSString stringWithFormat:@"%ld",_contentModel.praise]];
    //心情
    switch (contentModel.type) {
        case 0:
            [self.modeImageView setImage:[UIImage imageNamed:@"cry_icon"]];
            break;
        case 1:
            [self.modeImageView setImage:[UIImage imageNamed:@"badMode_icon_"]];
            break;
        case 2:
            [self.modeImageView setImage:[UIImage imageNamed:@"joke_icon"]];
            break;
        case 3:
            [self.modeImageView setImage:[UIImage imageNamed:@"goodMode_icon_"]];
            break;
        default:
            [self.modeImageView setImage:[UIImage imageNamed:@"goodMode_icon_"]];
            break;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickPraiseBtn:(UIButton *)sender {
}
@end
