//
//  HomeDetailHeaderView.h
//  Record
//
//  Created by 涂欢 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HomeContentModel;
@interface HomeDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *mobileNumL;
@property (weak, nonatomic) IBOutlet UIImageView *modeTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *praiseL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (nonatomic, strong) HomeContentModel*model;
+ (instancetype)viewWithXib;
@end

NS_ASSUME_NONNULL_END
