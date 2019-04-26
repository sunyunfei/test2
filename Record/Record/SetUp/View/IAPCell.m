//
//  IAPCell.m
//  Record
//
//  Created by 孙云飞 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import "IAPCell.h"

@implementation IAPCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(IAPModel *)model{
    
    _model = model;
    self.priceLabel.text = model.productPrice;
}
@end
