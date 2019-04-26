//
//  HomeDetailHeaderView.m
//  Record
//
//  Created by 涂欢 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import "HomeDetailHeaderView.h"
#import "HomeContentModel.h"
@implementation HomeDetailHeaderView
+ (instancetype)viewWithXib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeDetailHeaderView" owner:nil options:nil] lastObject];
}
- (void)setModel:(HomeContentModel *)model
{
    _model = model;
    //手机号
    [_mobileNumL setText:[Tool idNumberReplaceSecret:model.mobile]];
    //点赞
    [_praiseL setText:[NSString stringWithFormat:@"%ld",_model.praise]];
    //心情
    NSString *imageName = @"goodMode_icon_";
    switch (_model.type) {
        case 0:
            imageName =@"cry_icon";
            break;
        case 1:
            imageName =@"badMode_icon_";
            break;
        case 2:
            imageName =@"joke_icon";
            break;
        case 3:
            imageName =@"goodMode_icon_";
            break;
        default:
            imageName =@"goodMode_icon_";
            break;
    }
    
    [_modeTypeImageView setImage:[UIImage imageNamed:imageName]];
    //时间
    [_timeL setText:_model.date];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
