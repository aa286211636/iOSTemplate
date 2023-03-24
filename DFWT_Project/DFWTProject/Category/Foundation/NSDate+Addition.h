

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

/**
 *  获取当前时间戳
 */
+ (NSString *)currentTimeStamp;

//判断两个时间戳是否同一天
+ (BOOL)isSameDay:(NSString *)Time1 Time2:(NSString *)Time2;

/**
 *  判断是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  判断是否为今天
 */
- (BOOL)isToday;

/**
 *  判断是否为今年
 */
- (BOOL)isThisYear;

/**
 获取固定格式的时间字符串

 @param dateFromat 时间格式字符串
 @return 时间字符串
 */
- (NSString *)stringFromDateFormat:(NSString *)dateFromat;

/**
 通过时间字符串和时间格式获取时间

 @param dateStr 时间字符串
 @param dateFromat 时间格式字符串
 @return NSDate对象
 */
+ (NSDate *)dateFromString:(NSString *)dateStr dateFormat:(NSString *)dateFromat;
/**
 通过时间字符串和时间格式获取时间
 
 @param timestamp 时间字符串
 @param dateFromat 时间格式字符串
 @return NSDate对象
 */
+ (NSString *)dateFromTimestamp:(NSString *)timestamp dateFormat:(NSString *)dateFromat;

/**
  通过时间字符串获取时间
 时间字符串格式必须是 @"yyyy-MM-dd HH:mm:ss"
 @param dateStr 时间字符串
 @return NSDate对象
 */
+ (NSDate *)dateFromString:(NSString *)dateStr;

/**
 *  与当前时间比较格式化返回，例如：刚刚，5分钟前等 ,传入时间戳
 *
 *  @param compareDate 待比对的时间字符串
 *
 *  @return 比对结果
 */
+ (NSString *)compareCurrentTime:(NSString *)compareDate;

/**
 *  与当前时间比较格式化返回，例如：08：56，2016/08/30 08：56等 ,传入时间戳
 *
 *  @param dateStr 待比对的时间字符串
 *
 *  @return 比对结果
 */
+ (NSString *)compareDate:(NSString *)dateStr;

/**
 *  判断是不是今天
 *
 *  @param date 带比对时间
 *
 *  @return BOOL值 0/1
 */
+ (BOOL)isToday:(NSDate *)date;
/**
 *  判断是否为今年
 */
- (BOOL)isThisYear:(NSDate *)date;

/**
 *  判断是不是今天 ,传入标准时间
 *
 *  @param dateString 带比对时间
 *
 *  @return BOOL值 0/1
 */
+ (BOOL)isTodayWithString:(NSString *)dateString;

/**
 *  判断是不是今天 ,传入时间戳
 *
 *  @param timeInterval 带比对时间
 *
 *  @return BOOL值 0/1
 */
+ (BOOL)isTodayWithTimeInterval:(NSString *)timeInterval;

/**
 *  判断是不是昨天 ,传入标准时间
 *
 *  @param dateString 带比对时间
 *
 *  @return BOOL值 0/1
 */
+ (BOOL)isYersterdayWithString:(NSString *)dateString;

/**
 *  判断是不是昨天 ,传入时间戳
 *
 *  @param timeInterval 带比对时间
 *
 *  @return BOOL值 0/1
 */
+ (BOOL)isYersterdayWithTimeInterval:(NSString *)timeInterval;

/**
 *  时间戳转为时间
 *
 *  @param timeStamp 时间戳
 *
 *  @param formatter 时间格式
 *
 *  @return 星期
 */
+ (NSString *)dateFromTimestamp:(NSString *)timeStamp formatter:(NSString *)formatter;

//时间转时间戳
+ (NSString *)dateConversionTimeStamp:(NSDate *)date;
/**
 *
 *  @param dateString 时间字符串  "2021-06-02T07:45:14.000+00:00"
 *
 *  @return 时间戳
 */
+ (NSString *)getTimestampFromTime:(NSString *)dateString;


/**
 *  时间差
 *
 *  @param date 时间
 *
 *  @param otherDate 时间
 *
 *  @return 时间差（秒）
 */
+ (NSInteger)compareTimeIntervalDate:(NSDate *)date otherDate:(NSDate *)otherDate;

/**
 *  时间差
 *
 *  @param date 时间
 *
 *  @param otherDate 时间
 *
 *  @return 时间差（秒）
 */
+ (NSInteger)compareTimeInterval:(NSInteger)date other:(NSInteger)otherDate;

/**
 *  时间差
 *
 *  @param date 时间
 *
 *  @return 时间差（秒）
 */
+ (NSInteger)compareTimeFromCurrent:(NSInteger)date;

@end
