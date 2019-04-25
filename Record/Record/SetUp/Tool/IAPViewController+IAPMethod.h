//
//  IAPViewController+IAPMethod.h
//  Record
//
//  Created by 孙云飞 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import "IAPViewController.h"
#import "IAPShare.h"
NS_ASSUME_NONNULL_BEGIN

@interface IAPViewController (IAPMethod)
- (void)requestProductInfoSuccess:(void(^)(id respond))successBlock failure:(void(^)(void))failureBlock;
//订阅验证服务器
- (void)checkReceipt:(NSData *)receipt tran:(SKPaymentTransaction*)trans;
@end

NS_ASSUME_NONNULL_END
