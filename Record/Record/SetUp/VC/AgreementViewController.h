//
//  AgreementViewController.h
//  Record
//
//  Created by 孙云飞 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import "RootViewController.h"
typedef NS_ENUM(NSInteger,urlType) {
    
    PRIVATE,//隐私
    SERVICE//服务
};

NS_ASSUME_NONNULL_BEGIN

@interface AgreementViewController : RootViewController
@property (nonatomic,assign)urlType type;
@end

NS_ASSUME_NONNULL_END
