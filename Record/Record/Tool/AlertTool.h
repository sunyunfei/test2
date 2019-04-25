//
//  AlertTool.h
//  iSEE
//
//  Created by 孙云飞 on 2019/4/24.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,showType) {
  
  oneButton,//一个按钮
  twoButton,//两个按钮
};
@interface AlertTool : NSObject
//正常展示alert
+ (void)showALertTitle:(NSString *)title content:(NSString *)content showType:(showType)type sure:(void(^)(void))sureBlock cancel:(void(^)(void))cancelBlock;
@end

NS_ASSUME_NONNULL_END
