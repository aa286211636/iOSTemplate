//
//  NSString+Addition.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)
    
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL || string.length == 0) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


- (CGSize)sizeWithText:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    CGSize maxsize = CGSizeMake(maxW, MAXFLOAT);
    return  [self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

- (CGSize)sizeWithText:(UIFont *)font{
    return [self sizeWithText:font maxW:MAXFLOAT];
}

- (NSInteger)fileSize{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}


- (BOOL)isPhoneNumber {
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    return [self match:@"^1[3578]\\d{9}$"];
    // JavaScript的正则表达式:\^1[3578]\\d{9}$\
    
}

/**
 *  邮箱地址是否合法
 */
-(BOOL)isEmailWithString:(NSString *)str{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}

- (BOOL)match:(NSString *)pattern { //创建正则表达式
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

/**
 返回处理过的字符串，只保留小数点后两位，结尾0省略
 */
- (instancetype)dealedPriceString{
    
    NSString * curren = self;
    //    //如果有0.00就替换
    //    self.current_price.text = [curren stringByReplacingOccurrencesOfString:@"0.00" withString:@""];
    
    //截取字符串只显示0.92两位数值，结尾如果是0也给去掉
    //1，找到.的位置
    NSUInteger location =  [curren rangeOfString:@"."].location;
    if (location != NSNotFound) { //.找到了
        NSUInteger leng = curren.length - location - 1;
        if (leng > 2) {//说明字符串大于2就截取，截取到字符串.后面的位置
            curren = [curren substringToIndex:location + 3];
            if ([curren hasSuffix:@"0"]) { //后面如果以0结尾
                curren = [curren substringToIndex:curren.length -1];
            }
        }
    }
    return  curren;
}

/**
 * 判断中文和英文字符串的长度
 */
- (int)convertToInt:(NSString*)strtemp{
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}

//验证密码规则
- (BOOL)isValidPassword{
    BOOL result = NO;
    if ([self length] >= 6 && [self length] <= 16){
        //数字条件
        NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
        //符合数字条件的有几个
        NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self
                                                                           options:NSMatchingReportProgress
                                                                             range:NSMakeRange(0, self.length)];
        //英文字条件
        NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
        //符合英文字条件的有几个
        NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:self
                                                                                 options:NSMatchingReportProgress
                                                                                   range:NSMakeRange(0, self.length)];
        
        if(tNumMatchCount >= 1 && tLetterMatchCount >= 1){
            result = YES;
        }
    }
    return result;
}
 
//返回会议日期  "2021-06-02T07:45:14.000+00:00"
+ (NSString *)returnConferenceDate:(NSString *)dateStr{
    if (dateStr.length) {
        NSString *timeStr = [dateStr componentsSeparatedByString:@"."][0];
        return [timeStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }else{
        return nil;
    }
}
@end
