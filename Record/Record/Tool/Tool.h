//
//  Tool.h
//  AreaApplication
//
//  Created by 吕强 on 15/10/28.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tool : NSObject


/**
 *  精确判断身份证号码
 *
 *  @param cardNo <#cardNo description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)checkIdentityCardNo:(NSString*)value;
/**
 *  颜色转图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  获取字符串所占用的长度：计算一句话
 *
 *  @param font   字体
 *  @param string 字符串
 *
 *  @return CGSize
 */
+ (CGSize)sizeWithFont:(UIFont *)font textString:(NSString *)string;

/**
 *  创建富文本
 *
 *  @param color        颜色
 *  @param text         文本
 *  @param font         字体
 *  @param anOtherColor 颜色
 *  @param anOtherText  文本
 *  @param anOtherFont  字体
 *
 *  @return 富文本
 */
+ (NSMutableAttributedString *)attributedStringColor:(UIColor *)color
                                               text:(NSString *)text
                                               font:(UIFont *)font
                                       anOtherColor:(UIColor *)anOtherColor
                                        anOtherText:(NSString *)anOtherText
                                        anOtherFont:(UIFont *)anOtherFont;
/**
 *  判断设备类型
 *
 *  @param name 设备类型名称 iPhone iPod
 *
 *  @return BOOL
 */
+(bool)checkDevice:(NSString*)name;
/*
 **是否为网址
 */
+ (BOOL)isHttpPre:(NSString *)path;
/**
 *  字典转json
 *
 *  @param dic 字典
 *
 *  @return json
 */
+(NSString*)toCompactString:(NSDictionary *)dic;



/**
 *  邮箱
 *
 *  @param email 邮箱账号
 *
 *  @return BOOL
 */
+ (BOOL)validateEmail:(NSString*)email;

/**
 *  正则匹配用户密码6-20位数字或字母组合
 *
 *  @param password 密码
 *
 *  @return BOOL
 */
+ (BOOL)checkPassword:(NSString *) password;
/**
 *  四舍五入
 *
 *  @param price    金额
 *  @param position 保留几位小数
 *
 *  @return nil
 */
+(NSString *)notRounding:(float)price afterPoint:(int)position;

/**
 *  Number 转String
 *
 *  @param number Number
 *
 *  @return String
 */
+ (NSString *)stringFromeNumber:(NSNumber *)number;
/**
 *  字符串中是否包含空格
 *
 *  @param str string
 *
 *  @return BOOL
 */
+(BOOL)isBlank:(NSString *)str;
/**
 *  获取性别
 *
 *  @param idCard 身份证号
 *
 *  @return 1 男 2 女  0 未知
 */
+ (NSInteger)getSexFromIdCardSex:(NSString*)idCard;

+(void)showMBProgressHUDText:(MBProgressHUD *)hud Message:(NSString *)text Time:(NSInteger)time addView:(UIView *)addView FrameY:(CGFloat)y;
+(void)showMBProgressHUDText:(NSString *)text view:(UIView *)addView;
/**
 *  字节换算
 *
 *  @param count 字节
 *
 *  @return M／GB
 */
+ (NSString *)fileSizeWithByte:(int64_t)count;

+ (NSString *)valiMobile:(NSString *)mobile;

//判断苹果手机型号
+(BOOL)is5Sdown;

+ (UIImage*)createImageWithColor:(UIColor*)color Size:(CGSize)size;

/**
 判断是否全中文
 
 @param name 中文
 @return Bool
 */
+ (BOOL)isChinese:(NSString *)name;

/**
 身份证号加密显示

 @param idNumber 身份证号
 @return
 */
+ (NSString *)idNumberReplaceSecret:(NSString *)idNumber;
//判断登录
+ (BOOL)justifyTheUserInfo;


/**
 判断是不是字符有没有值，没有的话返回自定义字符
 */
+ (NSString *)isNSStringClass:(NSString *)str placeNSString:(NSString *)placeStr;

@end
