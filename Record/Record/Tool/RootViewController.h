//
//  RootViewController.h
//  Record
//
//  Created by 涂欢 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootViewController : UIViewController<UIGestureRecognizerDelegate>
/**
 *  调用添加返回按钮和手势
 */
- (void)addBackItemAndAction;
/**
 *  返回上一页
 */
- (void)backBefore;
@end

NS_ASSUME_NONNULL_END
