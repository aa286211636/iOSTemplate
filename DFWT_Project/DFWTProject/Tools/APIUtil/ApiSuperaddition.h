//
//  ApiSuperaddition.h
//
//  API请求追加单例，包括追加参数以及拦截code返回操作(code为字符串)
//
//

#import <Foundation/Foundation.h>

/**
 网络请求API追加相关管理工具类
 */
@interface ApiSuperaddition : NSObject

/**
 构造方法

 @return LNApiSuperaddition对象
 */
+ (instancetype)sharedSuperaddition;

/**
 忽略参数
 */
@property (nonatomic, copy) NSArray *ignoreFilterApi;

/**
 状态码
 */
@property (nonatomic, copy) NSArray *filterCode;

/**
 handler Block
 */
@property (nonatomic, copy) void(^FilterHandler)(NSString *code);

/**
 追加请求参数
 */
@property (nonatomic, copy) NSDictionary *additionArgumets;

/**
 请求头
 */
@property (nonatomic, copy) NSDictionary *httpHeaders;

/**
 追加请求参数

 @param configure 传入相关参数的block
 @param handler 请求数据返回状态码时的处理handler
 */
+ (void)superadditionConfigure:(void(^)(NSArray **ignoreFilterApi, NSArray **filterCode, NSDictionary **additionArgumets, NSDictionary **httpHeaders))configure filterHandler:(void (^)(NSString *code))handler;

@end
