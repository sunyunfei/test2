//
//  IAPCell.h
//  Record
//
//  Created by 孙云飞 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAPModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface IAPCell : UICollectionViewCell
@property (nonatomic,strong)IAPModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

NS_ASSUME_NONNULL_END
