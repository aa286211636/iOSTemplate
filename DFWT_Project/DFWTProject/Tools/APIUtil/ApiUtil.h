

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ApiRequestMethod) {
    ApiRequestMethodGET = 0,
    ApiRequestMethodPOSTForm,
    ApiRequestMethodPOSTBody,
    ApiRequestMethodPUT,
    ApiRequestMethodPUTBody,
    ApiRequestMethodDELETE,
    ApiRequestMethodDELETEBody
};

/**
 网络请求管理类
 */
@interface ApiUtil : NSObject

/**
 *  停止所有上传网络请求
 */
+ (void)cancelAllUploadTask;

/**
 发送模型对象数据请求
 
 @param url 请求地址
 @param arguments 请求参数
 @param requestMethod 请求方式
 @param MD5Encryption 是否加密
 @param httpHeaders 是否加密
 @param response 成功
 @param error 失败
 */
+ (void)sendModelRequestWithUrl:(NSString *)url arguments:(NSDictionary *)arguments requestMethod:(ApiRequestMethod)requestMethod MD5Encryption:(BOOL)MD5Encryption httpHeaders:(NSDictionary *)httpHeaders success:(void (^)(NSDictionary *jsonObject))response failed:(void (^)(NSError *error))error;

/**
 上传数据请求

 @param arguments 参数
 @param url 地址
 @param fileData 文件数据
 @param name 相关数据的name 不能为空
 @param fileName 存储的文件名 非空
 @param mimeType 文件类型
 @param httpHeaders 请求头
 @param uploadProgress 上传进度
 @param success 成功回调
 @param failur 失败回调
 */
+ (void)uploadWithArguments:(NSDictionary *)arguments requestURL:(NSString *)url fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType httpHeaders:(NSDictionary *)httpHeaders progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(NSDictionary *jsonObject))success failure:(void (^)(NSError *error))failur;
/**
 *  配置https单向认证证书 以及 baseUrl
 */
+ (void)configureHttpsServerCert:(NSString *)path;
+ (void)configureHttpsBaseUrl:(NSString *)baseUrl;
+ (void)configureHttpsServerCert:(NSString *)path baseUrl:(NSString *)baseUrlStr;

+ (void)configureHttpsUploadServerCert:(NSString *)path;
+ (void)configureHttpsUploadBaseUrl:(NSString *)baseUrl;
+ (void)configureHttpsUploadServerCert:(NSString *)path baseUrl:(NSString *)baseUrlStr;
@end
