//
//  TableViewCell.m
//  Record
//
//  Created by 涂欢 on 2019/4/23.
//  Copyright © 2019 syf. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.subsViews.layer.cornerRadius = 4;
    self.subsViews.clipsToBounds = YES;
<<<<<<< Updated upstream:Record/Record/HomePage/View/HomeTableViewCell.m

=======
    
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
//    effectview.frame = CGRectMake(_cntentL.frame.origin.x, _cntentL.frame.origin.y+20, [UIScreen mainScreen].bounds.size.width-40, _cntentL.frame.size.height-20);
////    [effectview setBackgroundColor:[UIColor lightGrayColor]];
////    [effectview setTintColor:[UIColor redColor]];
//    effectview.alpha = 0.9;
//    [self addSubview:effectview];
    
>>>>>>> Stashed changes:Record/Record/HomePage/HomeTableViewCell.m
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickPraiseBtn:(UIButton *)sender {
}
@end
