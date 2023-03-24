

#import "DFWT_GloabalManager.h"


@implementation DFWT_GloabalManager
+ (DFWT_GloabalManager *)sharedInstance {
    static DFWT_GloabalManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DFWT_GloabalManager alloc] init];
    });
    return manager;
}
@end
