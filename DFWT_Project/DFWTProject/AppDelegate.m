//
//  AppDelegate.m
//  DFWTProject
//
//  Created by Administrator on 2022/8/22.
//

#import "AppDelegate.h"
#import "DFWT_TabController.h"
#import "DFWT_LoginController.h"
#import "ApiSuperaddition.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configKeyBord];
    [self configWindow];
    [self configAPISuperaddition];
    return YES;
}

//配置键盘
- (void)configKeyBord{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside =YES; // 控制点击背景是否收起键盘
}

//配置窗口
- (void)configWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:[DFWT_LoginController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    [LEEAlert configMainWindow:self.window];
}

//配置token
- (void)configAPISuperaddition{
    //token过期拦截
    [ApiSuperaddition sharedSuperaddition].filterCode = @[@"401"];
    DEF_WeakSelf(self);
    [ApiSuperaddition sharedSuperaddition].FilterHandler = ^(NSString *code) {
        DEF_StrongSelf(self)
        DEF_RemoveUserDefault(@"TOKEN");
        DFWT_LoginController *vc = [[DFWT_LoginController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
        strongSelf.window.rootViewController = nav;
        [vc showHUDMessage:@"登陆过期，请重新登录"];
        return;
    };
}

@end
