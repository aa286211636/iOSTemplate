//
//  DFWT_AttendanceTabController.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/31.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_AttendanceTabController.h"
#import "DFWT_AttendanceController.h"
#import "DFWT_AttendanceApplyController.h"
#import "DFWT_AttendanceTotalController.h"
@interface DFWT_AttendanceTabController ()

@end

@implementation DFWT_AttendanceTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTab];
}


- (void)configTab{
    
    NSDictionary *dakaDict = @{
        CYLTabBarItemTitle : @"打卡",
        CYLTabBarItemImage : @"att_tab_daka_nor",
        CYLTabBarItemSelectedImage : @"att_tab_daka_sel",
    };
    NSDictionary *applyDict = @{
        CYLTabBarItemTitle : @"申请",
        CYLTabBarItemImage : @"att_tab_apply_nor",
        CYLTabBarItemSelectedImage : @"att_tab_apply_sel",
    };
    NSDictionary *totalDict = @{
        CYLTabBarItemTitle : @"统计",
        CYLTabBarItemImage : @"att_tab_total_nor",
        CYLTabBarItemSelectedImage : @"att_tab_total_sel",
    };

    self.tabBarItemsAttributes = @[dakaDict,applyDict,totalDict];
    [self customizeInterface];
    
    UINavigationController *dakaNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_AttendanceController new]];
    UINavigationController *applyNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_AttendanceApplyController new]];
    UINavigationController *totalNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_AttendanceTotalController new]];
    [self setViewControllers:@[dakaNav,applyNav,totalNav]];
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
