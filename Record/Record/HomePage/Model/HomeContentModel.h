//
//  HomeContentModel.h
//  Record
//
//  Created by 孙云飞 on 2019/4/24.
//  Copyright © 2019 syf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeContentModel : NSObject
@property (nonatomic,copy)NSString *objectId;//id
@property (nonatomic,copy)NSString *mobile;//加*手机号
@property (nonatomic,copy)NSString *content;//内容
@property (nonatomic,assign)NSInteger type;//类别   开心，愤怒，伤心，平常心
@property (nonatomic,copy)NSString *date; //时间
@property (nonatomic,assign)NSInteger praise;//点赞数
@end

NS_ASSUME_NONNULL_END
