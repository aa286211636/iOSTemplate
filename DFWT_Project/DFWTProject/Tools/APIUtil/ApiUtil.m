

#import "ApiUtil.h"
#import "ApiSuperaddition.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <objc/runtime.h>

#define kTimeOutInterval 30
#define kCode  @"code"   //接口token失效错误码404  //网关token失效错误码401

static char kApiHttpsCert = 'X';
static char kApiHttpsBaseUrl = 'B';

static char kApiHttpsUploadCert = 'UX';
static char kApiHttpsUploadBaseUrl = 'UB';

typedef void (^ApiSuccessBack) (NSDictionary *jsonObject);
typedef void (^ApifailedErrorBack) (NSError *error);
@interface ApiRequestFunc : NSObject

/**
 *   基本网络请求,(get,post)
 *
 *  @param arguments            参数
 *  @param url                  请求地址,短地址除去BaseUrl
 *  @param method               请求方式, ApiRequestMethod 枚举类型
 *  @param successBack          成功Block回调
 *  @param errorBack            失败Block回调
 */
+ (void)sendApiRequestWithArguments:(NSDictionary *)arguments requestURL:(NSString *)url requestMethod:(ApiRequestMethod)method MD5Encryption:(BOOL)MD5Encryption httpHeaders:(NSDictionary *)httpHeaders successBack:(ApiSuccessBack)successBack errorBack:(ApifailedErrorBack)errorBack;
/**
 *  上传图像、文件
 *
 *  @param arguments            参数
 *  @param url                  请求地址,短地址除去BaseUrl
 *  @param fileData             文件二进制
 *  @param name                 对接参数
 *  @param fileName             文件名
 *  @param mimeType             文件类型
 *  @param successBack          成功Block回调
 *  @param errorBack            失败Block回调
 */
+ (void)sendApiUploadWithArguments:(NSDictionary *)arguments requestURL:(NSString *)url fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType httpHeaders:(NSDictionary *)httpHeaders progress:(void (^)(NSProgress *))uploadProgress successBack:(ApiSuccessBack)successBack errorBack:(ApifailedErrorBack)errorBack;

/**
 *  停止所有上传网络请求
 */
+ (void)cancelAllUploadTask;
+ (void)setHttpsCertPath:(NSString *)path;
+ (void)setHttpsBaseUrl:(NSString *)baseUrl;

+ (void)setHttpsUploadCertPath:(NSString *)path;
+ (void)setHttpsUploadBaseUrl:(NSString *)baseUrl;
@end


@implementation ApiRequestFunc
static AFHTTPSessionManager *_instance;
- (AFHTTPSessionManager *)manager {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([ApiRequestFunc httpsBaseUrl].length > 0) {
        manager = [manager initWithBaseURL:[NSURL URLWithString:[ApiRequestFunc httpsBaseUrl]]];
    }
    if ([ApiRequestFunc httpsCertPath].length > 0) {
        manager.securityPolicy = [ApiRequestFunc customSecurityPolicy];
    }
    return manager;
}

+ (void)sendApiRequestWithArguments:(NSDictionary *)arguments requestURL:(NSString *)url requestMethod:(ApiRequestMethod)method MD5Encryption:(BOOL)MD5Encryption httpHeaders:(NSDictionary *)httpHeaders successBack:(ApiSuccessBack)successBack errorBack:(ApifailedErrorBack)errorBack {
    NSMutableDictionary *newArguments = [NSMutableDictionary dictionary];
    [arguments enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *utf8Str = obj;
            NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\|";
            NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
            NSString *encodedString = [utf8Str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
            [newArguments setObject:encodedString forKey:key];
        }
    }];
    
    DEF_Log(@"***** RequestURL: ***** %@",url);
    DEF_Log(@"***** arguments: ***** %@",arguments);
    NSDictionary *encryptionDict = arguments;
    NSURL *originalUrl = [NSURL URLWithString:url];
    NSString *host = originalUrl.host;
    NSNumber *port = originalUrl.port;
    NSString *scheme = originalUrl.scheme;
    NSString *baseUrl = [NSString stringWithFormat:@"%@://%@:%@/", scheme, host, port];
    AFHTTPSessionManager *manger = [[self alloc] manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.requestSerializer.timeoutInterval = kTimeOutInterval;

    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manger.responseSerializer = response;

    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/JavaScript", nil];
        //配置token
        NSString *token = DEF_GetUserDefault(@"TOKEN");
        if (token.length) {
            [ApiSuperaddition sharedSuperaddition].httpHeaders = @{@"Authorization":token};
        }
     if ([ApiSuperaddition sharedSuperaddition].httpHeaders.allKeys.count > 0) {
        [[ApiSuperaddition sharedSuperaddition].httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manger.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    if (httpHeaders.allKeys.count > 0) {
        [httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manger.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    if (method == ApiRequestMethodGET) {
        NSArray *urls = [url componentsSeparatedByString:@"?"];
        if ([ApiSuperaddition sharedSuperaddition].additionArgumets.allKeys.count > 0 && ![[ApiSuperaddition sharedSuperaddition].ignoreFilterApi containsObject:[urls.firstObject componentsSeparatedByString:baseUrl].lastObject]) {
            
            for (int i = 0; i < [ApiSuperaddition sharedSuperaddition].additionArgumets.allKeys.count ; i ++) {
                NSString *key = [ApiSuperaddition sharedSuperaddition].additionArgumets.allKeys[i];
                if (i == 0) {
                    if (urls.count > 1) {
                        url = [url stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", key, [ApiSuperaddition sharedSuperaddition].additionArgumets[key]]];
                    } else {
                        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@=%@", key, [ApiSuperaddition sharedSuperaddition].additionArgumets[key]]];
                    }
                } else {
                    url = [url stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", key, [ApiSuperaddition sharedSuperaddition].additionArgumets[key]]];
                }
            }
        }
        
        [manger GET:url parameters:encryptionDict headers:httpHeaders progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //Token失效分为网关拦截和接口返回错误码拦截
             DEF_Log(@"***** RequestSuccess: ***** %@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
            if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:[NSString stringWithFormat:@"%@", responseObject[kCode]]]) {
                if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                    [ApiSuperaddition sharedSuperaddition].FilterHandler(responseObject[kCode]);
                }
            } else {
                if (successBack) {
                    successBack(responseObject);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorBack) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                NSString *statusCode = [NSString stringWithFormat:@"%ld",response.statusCode];
                if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:statusCode]) {
                    if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                        [ApiSuperaddition sharedSuperaddition].FilterHandler(statusCode);
                    }
                }
                DEF_Log(@"***** RequestError: ***** %@",error);
                errorBack(error);
            }
        }];
    } else if (method == ApiRequestMethodPOSTForm) {
        DEF_Log(@"***** arguments: ***** %@",encryptionDict);
        NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:encryptionDict];
        
        if ([ApiSuperaddition sharedSuperaddition].additionArgumets.allKeys.count > 0 && ![[ApiSuperaddition sharedSuperaddition].ignoreFilterApi containsObject:[url componentsSeparatedByString:baseUrl].lastObject]) {
            [[ApiSuperaddition sharedSuperaddition].additionArgumets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if (![dictM.allKeys containsObject:key]) {
                    [dictM setObject:obj forKey:key];
                }
            }];
        }
        
        [manger POST: url parameters:dictM headers:httpHeaders progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DEF_Log(@"***** RequestSuccess: ***** %@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
            //Token失效分为网关拦截和接口返回错误码拦截
            if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:[NSString stringWithFormat:@"%@", responseObject[kCode]]]) {
                if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                    [ApiSuperaddition sharedSuperaddition].FilterHandler(responseObject[kCode]);
                }
            } else {
                if (successBack) {
                    successBack(responseObject);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorBack) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                NSString *statusCode = [NSString stringWithFormat:@"%ld",response.statusCode];
                if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:statusCode]) {
                    if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                        [ApiSuperaddition sharedSuperaddition].FilterHandler(statusCode);
                    }
                }
                DEF_Log(@"***** RequestError: ***** %@",error);
                errorBack(error);
            }
        }];
    } else if (method == ApiRequestMethodPOSTBody) {
        DEF_Log(@"***** arguments: ***** %@",encryptionDict);
        NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:encryptionDict];
        
        if ([ApiSuperaddition sharedSuperaddition].additionArgumets.allKeys.count > 0 && ![[ApiSuperaddition sharedSuperaddition].ignoreFilterApi containsObject:[url componentsSeparatedByString:baseUrl].lastObject]) {
            [[ApiSuperaddition sharedSuperaddition].additionArgumets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if (![dictM.allKeys containsObject:key]) {
                    [dictM setObject:obj forKey:key];
                }
            }];
        }
        NSData *body  =[[self dictionaryToJson:dictM] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
        if ([ApiSuperaddition sharedSuperaddition].httpHeaders.allKeys.count > 0) {
            [[ApiSuperaddition sharedSuperaddition].httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request setValue:obj forHTTPHeaderField:key];
            }];
        }
        
        if (httpHeaders.allKeys.count > 0) {
            [httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request setValue:obj forHTTPHeaderField:key];
            }];
        }
        [request setHTTPBody:body];
        
        NSURLSessionDataTask *task = [manger dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {
                DEF_Log(@"***** RequestSuccess: ***** %@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
                //Token失效分为网关拦截和接口返回错误码拦截
                if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:[NSString stringWithFormat:@"%@", responseObject[kCode]]]) {
                    if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                        [ApiSuperaddition sharedSuperaddition].FilterHandler(responseObject[kCode]);
                    }
                } else {
                    if (successBack) {
                        successBack(responseObject);
                    }
                }

            } else {
                if (errorBack) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                    NSString *statusCode = [NSString stringWithFormat:@"%ld",response.statusCode];
                    if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:statusCode]) {
                        if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                            [ApiSuperaddition sharedSuperaddition].FilterHandler(statusCode);
                        }
                    }
                    DEF_Log(@"***** RequestError: ***** %@",error);
                    errorBack(error);
                }
            }
        }];
        
        [task resume];
    }else if (method == ApiRequestMethodPUT) {
        DEF_Log(@"***** arguments: ***** %@",encryptionDict);
        NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:encryptionDict];
        
        if ([ApiSuperaddition sharedSuperaddition].additionArgumets.allKeys.count > 0 && ![[ApiSuperaddition sharedSuperaddition].ignoreFilterApi containsObject:[url componentsSeparatedByString:baseUrl].lastObject]) {
            [[ApiSuperaddition sharedSuperaddition].additionArgumets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if (![dictM.allKeys containsObject:key]) {
                    [dictM setObject:obj forKey:key];
                }
            }];
        }
        
        [manger PUT:url parameters:dictM headers:httpHeaders success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DEF_Log(@"***** RequestSuccess: ***** %@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
            //Token失效分为网关拦截和接口返回错误码拦截
               if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:[NSString stringWithFormat:@"%@", responseObject[kCode]]]) {
                if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                    [ApiSuperaddition sharedSuperaddition].FilterHandler(responseObject[kCode]);
                }
            } else {
                if (successBack) {
                    successBack(responseObject);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorBack) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                NSString *statusCode = [NSString stringWithFormat:@"%ld",response.statusCode];
                if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:statusCode]) {
                    if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                        [ApiSuperaddition sharedSuperaddition].FilterHandler(statusCode);
                    }
                }
                DEF_Log(@"***** RequestError: ***** %@",error);
                errorBack(error);
            }
        }];
        
    }  else if (method == ApiRequestMethodPUTBody) {
        DEF_Log(@"***** arguments: ***** %@",encryptionDict);
        NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:encryptionDict];
        
        NSData *body  =[[self dictionaryToJson:dictM] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:url parameters:nil error:nil];
        if ([ApiSuperaddition sharedSuperaddition].httpHeaders.allKeys.count > 0) {
            [[ApiSuperaddition sharedSuperaddition].httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request addValue:obj forHTTPHeaderField:key];
            }];
        }

        if (httpHeaders.allKeys.count > 0) {
            [httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request addValue:obj forHTTPHeaderField:key];
            }];
        }
        [request setHTTPBody:body];

        NSURLSessionDataTask *task = [manger dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {
                DEF_Log(@"***** RequestSuccess: ***** %@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
                //Token失效分为网关拦截和接口返回错误码拦截
                if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:[NSString stringWithFormat:@"%@", responseObject[kCode]]]) {
                    if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                        [ApiSuperaddition sharedSuperaddition].FilterHandler(responseObject[kCode]);
                    }
                } else {
                    if (successBack) {
                        successBack(responseObject);
                    }
                }

            } else {
                if (errorBack) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                    NSString *statusCode = [NSString stringWithFormat:@"%ld",response.statusCode];
                    if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:statusCode]) {
                        if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                            [ApiSuperaddition sharedSuperaddition].FilterHandler(statusCode);
                        }
                    }
                    DEF_Log(@"***** RequestError: ***** %@",error);
                    errorBack(error);
                }
            }
        }];

        [task resume];
        
    }  else if (method == ApiRequestMethodDELETE) {
        DEF_Log(@"***** arguments: ***** %@",encryptionDict);
        
        NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:encryptionDict];
        
        if ([ApiSuperaddition sharedSuperaddition].additionArgumets.allKeys.count > 0 && ![[ApiSuperaddition sharedSuperaddition].ignoreFilterApi containsObject:[url componentsSeparatedByString:baseUrl].lastObject]) {
            [[ApiSuperaddition sharedSuperaddition].additionArgumets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if (![dictM.allKeys containsObject:key]) {
                    [dictM setObject:obj forKey:key];
                }
            }];
        }
        [manger DELETE:url parameters:dictM headers:httpHeaders success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DEF_Log(@"***** RequestSuccess: ***** %@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
            //Token失效分为网关拦截和接口返回错误码拦截
            if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:[NSString stringWithFormat:@"%@", responseObject[kCode]]]) {
                if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                    [ApiSuperaddition sharedSuperaddition].FilterHandler(responseObject[kCode]);
                }
            } else {
                if (successBack) {
                    successBack(responseObject);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (errorBack) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                NSString *statusCode = [NSString stringWithFormat:@"%ld",response.statusCode];
                if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:statusCode]) {
                    if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                        [ApiSuperaddition sharedSuperaddition].FilterHandler(statusCode);
                    }
                }
                DEF_Log(@"***** RequestError: ***** %@",error);
                errorBack(error);
            }
        }];
        
    } else if (method == ApiRequestMethodDELETEBody) {
        DEF_Log(@"***** arguments: ***** %@",encryptionDict);
        
        NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:encryptionDict];
        
        NSData *body  =[[self dictionaryToJson:dictM] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"DELETE" URLString:url parameters:nil error:nil];
        if ([ApiSuperaddition sharedSuperaddition].httpHeaders.allKeys.count > 0) {
            [[ApiSuperaddition sharedSuperaddition].httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request addValue:obj forHTTPHeaderField:key];
            }];
        }

        if (httpHeaders.allKeys.count > 0) {
            [httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request setValue:obj forHTTPHeaderField:key];
            }];
        }
        [request setHTTPBody:body];

        NSURLSessionDataTask *task = [manger dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {
                DEF_Log(@"***** RequestSuccess: ***** %@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
                //Token失效分为网关拦截和接口返回错误码拦截
                if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:[NSString stringWithFormat:@"%@", responseObject[kCode]]]) {
                    if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                        [ApiSuperaddition sharedSuperaddition].FilterHandler(responseObject[kCode]);
                    }
                } else {
                    if (successBack) {
                        successBack(responseObject);
                    }
                }

            } else {
                if (errorBack) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                    NSString *statusCode = [NSString stringWithFormat:@"%ld",response.statusCode];
                    if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:statusCode]) {
                        if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                            [ApiSuperaddition sharedSuperaddition].FilterHandler(statusCode);
                        }
                    }
                    DEF_Log(@"***** RequestError: ***** %@",error);
                    errorBack(error);
                }
            }
        }];

        [task resume];
        
    }
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    
    NSError *parseError =nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}



+ (void)sendApiUploadWithArguments:(NSDictionary *)arguments requestURL:(NSString *)url fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType httpHeaders:(NSDictionary *)httpHeaders progress:(void (^)(NSProgress *))uploadProgress successBack:(ApiSuccessBack)successBack errorBack:(ApifailedErrorBack)errorBack {
    DEF_Log(@"***** RequestURL: ***** %@",url);
    NSURL *originalUrl = [NSURL URLWithString:url];
    NSString *host = originalUrl.host;
    NSNumber *port = originalUrl.port;
    NSString *scheme = originalUrl.scheme;
    NSString *baseUrl = [NSString stringWithFormat:@"%@://%@:%@/", scheme, host, port];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:arguments];
    
    if ([ApiSuperaddition sharedSuperaddition].additionArgumets.allKeys.count > 0 && ![[ApiSuperaddition sharedSuperaddition].ignoreFilterApi containsObject:[url componentsSeparatedByString:baseUrl].lastObject]) {
        [[ApiSuperaddition sharedSuperaddition].additionArgumets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [dictM setObject:obj forKey:key];
        }];
    }
    AFHTTPSessionManager *manger = [[self alloc] manager];
//    multipart/form-data
    if ([ApiRequestFunc httpsBaseUrl].length > 0) {
        manger = [manger initWithBaseURL:[NSURL URLWithString:[ApiRequestFunc httpsUploadBaseUrl]]];
    }
    if ([ApiRequestFunc httpsCertPath].length > 0) {
        manger.securityPolicy = [ApiRequestFunc customUploadSecurityPolicy];
    }
    
    if ([ApiSuperaddition sharedSuperaddition].httpHeaders.allKeys.count > 0) {
        [[ApiSuperaddition sharedSuperaddition].httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manger.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    if (httpHeaders.allKeys.count > 0) {
        [httpHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manger.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }

    [manger POST:url parameters:dictM headers:httpHeaders constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DEF_Log(@"***** RequestImageSuccess: ***** %@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
        //Token失效分为网关拦截和接口返回错误码拦截
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSString *statusCode = [NSString stringWithFormat:@"%ld",response.statusCode];
        if ([[ApiSuperaddition sharedSuperaddition].filterCode containsObject:[NSString stringWithFormat:@"%@", responseObject[kCode]]] || [[ApiSuperaddition sharedSuperaddition].filterCode containsObject:statusCode]) {
            if ([ApiSuperaddition sharedSuperaddition].FilterHandler) {
                [ApiSuperaddition sharedSuperaddition].FilterHandler(responseObject[kCode]);
            }
        } else {
            if (successBack) {
                successBack(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DEF_Log(@"***** RequestImageError: ***** %@",error);
        
        if (errorBack) {
            errorBack(error);
        }
    }];
}

const char *kUPLOADMANAGERS;

+ (NSMutableArray <AFHTTPSessionManager *>*)getUploadManagers {
    return objc_getAssociatedObject(self, &kUPLOADMANAGERS);
}

+ (void)setUploadManagers:(AFHTTPSessionManager *)manager {
    if (!manager) {
        return;
    }
    NSMutableArray *arrM = [self getUploadManagers];
    if (!arrM) {
        arrM = [NSMutableArray array];
    }
    [arrM addObject:manager];
    objc_setAssociatedObject(self, &kUPLOADMANAGERS, arrM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)cancelAllUploadTask {
    NSMutableArray *arrM = [self getUploadManagers];
    for (AFHTTPSessionManager *manager in arrM) {
        [manager.operationQueue cancelAllOperations];
    }
}

/**** SSL Pinning ****/
+ (AFSecurityPolicy *)customSecurityPolicy {
    NSString *cerPath = [self httpsCertPath];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    NSSet *set = [NSSet setWithObjects:certData, nil];
    [securityPolicy setPinnedCertificates:set];
    /**** SSL Pinning ****/
    return securityPolicy;
}

+ (AFSecurityPolicy *)customUploadSecurityPolicy {
    NSString *cerPath = [self httpsUploadCertPath];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    NSSet *set = [NSSet setWithObjects:certData, nil];
    [securityPolicy setPinnedCertificates:set];
    /**** SSL Pinning ****/
    return securityPolicy;
}

+ (NSString *)httpsCertPath {
    return objc_getAssociatedObject(self,  &kApiHttpsCert);
}

+ (void)setHttpsCertPath:(NSString *)path {
    if (path.length > 0) {
        objc_setAssociatedObject(self, &kApiHttpsCert, path, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

+ (NSString *)httpsBaseUrl {
    return objc_getAssociatedObject(self,  &kApiHttpsBaseUrl);
}

+ (void)setHttpsBaseUrl:(NSString *)baseUrl {
    if (baseUrl.length > 0) {
        objc_setAssociatedObject(self, &kApiHttpsBaseUrl, baseUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

+ (NSString *)httpsUploadCertPath {
    return objc_getAssociatedObject(self,  &kApiHttpsUploadCert);
}

+ (void)setHttpsUploadCertPath:(NSString *)path {
    if (path.length > 0) {
        objc_setAssociatedObject(self, &kApiHttpsUploadCert, path, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

+ (NSString *)httpsUploadBaseUrl {
    return objc_getAssociatedObject(self,  &kApiHttpsUploadBaseUrl);
}

+ (void)setHttpsUploadBaseUrl:(NSString *)baseUrl {
    if (baseUrl.length > 0) {
        objc_setAssociatedObject(self, &kApiHttpsUploadBaseUrl, baseUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

@end


@implementation ApiUtil

+ (void)cancelAllUploadTask {
    [ApiRequestFunc cancelAllUploadTask];
}

+ (void)sendModelRequestWithUrl:(NSString *)url arguments:(NSDictionary *)arguments requestMethod:(ApiRequestMethod)requestMethod MD5Encryption:(BOOL)MD5Encryption httpHeaders:(NSDictionary *)httpHeaders  success:(void (^)(NSDictionary *jsonObject))response failed:(void (^)(NSError *error))error {
    [ApiRequestFunc sendApiRequestWithArguments:arguments requestURL:url requestMethod:requestMethod MD5Encryption:MD5Encryption httpHeaders:httpHeaders successBack:response errorBack:error];
}

+ (void)uploadWithArguments:(NSDictionary *)arguments requestURL:(NSString *)url fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType httpHeaders:(NSDictionary *)httpHeaders progress:(void (^)(NSProgress *progress))uploadProgress success:(void (^)(NSDictionary *jsonObject))success failure:(void (^)(NSError *error))failur {
    [ApiRequestFunc sendApiUploadWithArguments:arguments requestURL:url fileData:fileData name:name fileName:fileName mimeType:mimeType httpHeaders:httpHeaders progress:uploadProgress successBack:success errorBack:failur];
}

+ (void)configureHttpsServerCert:(NSString *)path {
    [ApiRequestFunc setHttpsCertPath:path];
}

+ (void)configureHttpsBaseUrl:(NSString *)baseUrl {
    [ApiRequestFunc setHttpsBaseUrl:baseUrl];
}

+ (void)configureHttpsServerCert:(NSString *)path baseUrl:(NSString *)baseUrlStr {
    [ApiRequestFunc setHttpsCertPath:path];

    [ApiRequestFunc setHttpsBaseUrl:baseUrlStr];

}

+ (void)configureHttpsUploadServerCert:(NSString *)path {
    [ApiRequestFunc setHttpsUploadCertPath:path];

}
+ (void)configureHttpsUploadBaseUrl:(NSString *)baseUrl {
    [ApiRequestFunc setHttpsUploadBaseUrl:baseUrl];

}
+ (void)configureHttpsUploadServerCert:(NSString *)path baseUrl:(NSString *)baseUrlStr {
    [ApiRequestFunc setHttpsUploadCertPath:path];
    
    [ApiRequestFunc setHttpsUploadBaseUrl:baseUrlStr];

}

@end


