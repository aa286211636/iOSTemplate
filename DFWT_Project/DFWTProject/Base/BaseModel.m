

#import "BaseModel.h"
#import <objc/runtime.h>

/** 归档 */
#define YYModelSynthCoderAndHash \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { return [self yy_modelInitWithCoder:aDecoder]; } \
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; } \
- (NSUInteger)hash { return [self yy_modelHash]; } \
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }

const char RSBaseModelRequestUrlKey;
const char RSBaseModelRequestArgumentsKey;
const char RSBaseModelRequestRequestMethodKey;
const char RSBaseModelRequestMD5EncryptionKey;
const char RSBaseModelRequestHTTPHeadersKey;

@implementation BaseModel

/** 映射模型中的属性 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

/** 映射模型中的容器类型属性 数组/字典/集合 */
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{};
}

YYModelSynthCoderAndHash

+ (void)fetchDataConfigure:(void(^)(NSDictionary **arguments, NSString **requestUrl,ApiRequestMethod *requestMethod, BOOL *MD5Encryption, NSDictionary **HTTPHeaders))requestConfigure complate:(void (^)(BOOL finished, NSDictionary *jsonObject, id resultModel, NSError *error))handler {
    if (requestConfigure) {
        NSDictionary *arguments;
        NSString *requestUrl;
        ApiRequestMethod requestMethod;
        BOOL MD5Encryption;
        NSDictionary *HTTPHeaders;
        
        requestConfigure(&arguments, &requestUrl, &requestMethod, &MD5Encryption, &HTTPHeaders);
        
        objc_setAssociatedObject(self, &RSBaseModelRequestArgumentsKey, arguments, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &RSBaseModelRequestUrlKey, requestUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &RSBaseModelRequestRequestMethodKey, @(requestMethod), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &RSBaseModelRequestMD5EncryptionKey, @(MD5Encryption), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &RSBaseModelRequestHTTPHeadersKey, HTTPHeaders, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    __weak __typeof(self)weakSelf = self;
    [ApiUtil sendModelRequestWithUrl:[self requestUrl] arguments:[self arguments] requestMethod:[self requestMethod] MD5Encryption:[self MD5Encryption] httpHeaders:[self HttpHeaders] success:^(NSDictionary *jsonObject) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if ([strongSelf isNullOrNilWithObject:jsonObject]) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"result is Null"                                                                      forKey:NSLocalizedDescriptionKey];

            NSError *error = [NSError errorWithDomain:CustomErrorDomain code:1001 userInfo:userInfo];
            handler(YES, nil, nil, error);
        } else {
            id model = [[strongSelf class] yy_modelWithDictionary:jsonObject];
            handler(YES, jsonObject, model, nil);
        }
    } failed:^(NSError *error) {
        handler(NO, nil, nil, error);
    }];
}

+ (NSDictionary *)HttpHeaders {
    NSDictionary *httpHeaders = objc_getAssociatedObject(self, &RSBaseModelRequestHTTPHeadersKey);
    if (httpHeaders) {
        return httpHeaders;
    }
    return nil;
}

+ (ApiRequestMethod)requestMethod {
    
    id method = objc_getAssociatedObject(self, &RSBaseModelRequestRequestMethodKey);
    if (method) {
        return [method integerValue];
    }
    return ApiRequestMethodGET;
}

+ (NSString *)requestUrl {
    NSString *url = objc_getAssociatedObject(self, &RSBaseModelRequestUrlKey);
    if (url) {
        return url;
    }
    return @"";
}

+ (NSDictionary *)arguments {
    NSDictionary *argumetns = objc_getAssociatedObject(self, &RSBaseModelRequestArgumentsKey);
    if (argumetns) {
        return argumetns;
    }
    return nil;
}

+ (BOOL)MD5Encryption {
    id md5 = objc_getAssociatedObject(self, &RSBaseModelRequestMD5EncryptionKey);
    if (md5) {
        return [md5 integerValue];
    }
    return NO;
}

+ (BOOL)isNullOrNilWithObject:(id)object {
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else if ([object isEqualToString:@"null"] || [object isEqualToString:@"(null)"]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}

@end
