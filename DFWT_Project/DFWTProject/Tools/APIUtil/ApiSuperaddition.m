

#import "ApiSuperaddition.h"

static ApiSuperaddition *_sharedInstance = nil;

@implementation ApiSuperaddition

+ (instancetype)sharedSuperaddition {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self new];
    });
    return _sharedInstance;
}

+ (void)superadditionConfigure:(void(^)(NSArray **ignoreFilterApi, NSArray **filterCode, NSDictionary **additionArgumets, NSDictionary **httpHeaders))configure filterHandler:(void (^)(NSString *code))handler {
    [self sharedSuperaddition];
    if (configure) {
        NSArray *ignoreFilterApi;
        NSArray *filterCode;
        NSDictionary *arguments;
        NSDictionary *httpHeaders;
        configure(&ignoreFilterApi, &filterCode, &arguments, &httpHeaders);
        _sharedInstance.filterCode = filterCode;
        _sharedInstance.additionArgumets = arguments;
        _sharedInstance.ignoreFilterApi = ignoreFilterApi;
        _sharedInstance.httpHeaders = httpHeaders;
    }
    
    if (handler) {
        _sharedInstance.FilterHandler = handler;
    }
}

@end
