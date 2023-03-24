

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import <UIKit/UIKit.h>
#import "ApiUtil.h"

static NSString * const CustomErrorDomain = @"CustomErrorDomain";

/**
 Model的基类
 */
@interface BaseModel : NSObject<NSCoding>
/**
 子类重写返回请求参数体
 @return 请求参数体
 */
+ (NSDictionary *)arguments;

/**
 子类重写返回请求方式
 
 @return 请求方式
 */
+ (ApiRequestMethod)requestMethod;

/**
 子类重写发送请求地址
 
 @return 请求url
 */
+ (NSString *)requestUrl;

/**
 子类重写返回是否是用MD5加密
 
 @return 是否用MD5加密
 */
+ (BOOL)MD5Encryption;

/**
 子类模型类直接调用此方法生成对应的模型对象,注意:此处模型结构要与返回数据结构一样, 否则会导致模型转换失败
 
 @param requestConfigure 请求参数配置（请求体、url、请求方式、MD5加密与否）
 @param handler 回调
 */
+ (void)fetchDataConfigure:(void(^)(NSDictionary **arguments, NSString **requestUrl,ApiRequestMethod *requestMethod, BOOL *MD5Encryption, NSDictionary **HTTPHeaders))requestConfigure complate:(void (^)(BOOL finished, NSDictionary *jsonObject, id resultModel, NSError *error))handler;

@end
