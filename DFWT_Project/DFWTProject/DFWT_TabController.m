
#import "DFWT_TabController.h"
#import "DFWT_DocumentController.h"
#import "DFWT_AddressbookController.h"
#import "DFWT_MineController.h"
#import "DFWT_WorktableController.h"
#import "DFWT_MessageController.h"

@interface DFWT_TabController ()

@end

@implementation DFWT_TabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTab];
}


- (void)configTab{
    
    NSDictionary *messageDict = @{
        CYLTabBarItemTitle : @"消息",
        CYLTabBarItemImage : @"comments_nor",
        CYLTabBarItemSelectedImage : @"comments_sel",
    };
    NSDictionary *documentDict = @{
        CYLTabBarItemTitle : @"文档",
        CYLTabBarItemImage : @"folder_nor",
        CYLTabBarItemSelectedImage : @"folder_sel",
    };
    NSDictionary *worktableDict = @{
        CYLTabBarItemTitle : @"工作台",
        CYLTabBarItemImage : @"workbench_nor",
        CYLTabBarItemSelectedImage : @"workbench_sel",
    };
    NSDictionary *addressbookDict = @{
        CYLTabBarItemTitle : @"通讯录",
        CYLTabBarItemImage : @"addressbook_nor",
        CYLTabBarItemSelectedImage : @"addressbook_sel",
    };
    NSDictionary *mineDict = @{
        CYLTabBarItemTitle : @"我的",
        CYLTabBarItemImage : @"people_nor",
        CYLTabBarItemSelectedImage : @"people_sel",
    };
    self.tabBarItemsAttributes = @[messageDict,documentDict,worktableDict,addressbookDict,mineDict];
    [self customizeInterface];
    
    UINavigationController *messageNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_MessageController new]];
    UINavigationController *documentNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_DocumentController new]];
    UINavigationController *worktableNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_WorktableController new]];
    UINavigationController *addressbookNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_AddressbookController new]];
    UINavigationController *mineNav = [[UINavigationController alloc]initWithRootViewController:[DFWT_MineController new]];
    [self setViewControllers:@[messageNav,documentNav,worktableNav,addressbookNav,mineNav]];
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
