//
//  NSString+Addition.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (Addition)
    
/**
判断是否是否空串
@return YES：是，NO：不是
*/
+ (BOOL)isBlankString:(NSString *)string;
    
/**
 去掉字符串中的空格和换行

 @return 无空格和换行的字符串
 */

/**
 根据字体大小和换行需要最大换行距离计算 size

 @param font 字体
 @param maxW 换行需要最大换行距离
 @return 最终 string 的 size
 */
- (CGSize)sizeWithText:(UIFont *)font maxW:(CGFloat)maxW;

/**
 计算特定字体下展示 string 需要的 size

 @param font string 的字体
 @return 所需的 size
 */
- (CGSize)sizeWithText:(UIFont *)font;

/**
 *  计算当前文件\文件夹的内容大小
 
 @return 当前文件\文件夹的内容大小
 */
- (NSInteger)fileSize;

/**
 判断是否为合法的手机号

 @return YES：是，NO：不是
 */
- (BOOL)isPhoneNumber;

/**
 判断是否为合法的邮箱

 @param str 校验的字符串
 @return YES：是，NO：不是
 */
-(BOOL)isEmailWithString:(NSString *)str;

/**
 返回价格形式的字符串，只保留小数点后两位，结尾0省略

 @return 格式化后的字符串
 */
- (instancetype)dealedPriceString;

/**
 判断中文和英文字符串的长度

 @param strtemp 目标字符串
 @return 字符串长度
 */
- (int)convertToInt:(NSString*)strtemp;

//验证密码规则
/**
 判断是否为合法密码
 
 @return YES：是，NO：不是
 */
- (BOOL)isValidPassword;


//返回会议日期
+ (NSString *)returnConferenceDate:(NSString *)dateStr;
@end
