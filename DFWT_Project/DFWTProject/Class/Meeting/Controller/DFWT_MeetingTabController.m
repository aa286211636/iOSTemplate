//
//  DFWT_MeetingTabController.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/4.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MeetingTabController.h"
#import "DFWT_MeetHomeController.h"
#import "DFWT_MeetPhoneController.h"
#import "DFWT_MeetSettingController.h"

@interface DFWT_MeetingTabController ()

@end

@implementation DFWT_MeetingTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTab];
}


- (void)configTab{
    
    NSDictionary *ZYYLDict = @{
        CYLTabBarItemTitle : @"中油易连",
        CYLTabBarItemImage : @"meettab_meet_nor",
        CYLTabBarItemSelectedImage : @"meettab_meet_sel",
    };
    NSDictionary *phoneDict = @{
        CYLTabBarItemTitle : @"拨号盘",
        CYLTabBarItemImage : @"meettab_phone_nor",
        CYLTabBarItemSelectedImage : @"meettab_phone_sel",
    };
    NSDictionary *settingDict = @{
        CYLTabBarItemTitle : @"设置",
        CYLTabBarItemImage : @"meettab_set_nor",
        CYLTabBarItemSelectedImage : @"meettab_set_sel",
    };

    self.tabBarItemsAttributes = @[ZYYLDict,phoneDict,settingDict];
    [self customizeInterface];
    
    UINavigationController *ZYYLNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_MeetHomeController new]];
    UINavigationController *phoneNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_MeetPhoneController new]];
    UINavigationController *settingNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_MeetSettingController new]];
    [self setViewControllers:@[ZYYLNav,phoneNav,settingNav]];
}


- (void)customizeInterface {
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = DEF_HEXColor(0x8a8a8a);
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = DEF_APPCOLOR;
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end

