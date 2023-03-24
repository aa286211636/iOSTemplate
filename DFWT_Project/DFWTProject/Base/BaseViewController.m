

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DEF_BACKCOLOR;
    if (self.navigationController) {
         [self configNav];
    }
 }

- (void)configNav{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    self.navigationController.navigationBar.titleTextAttributes = attrs;
    //设置导航条颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:DEF_NAVCOLOR] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    //设置返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 54, 30);
    [back setImage:[UIImage imageNamed:@"arrow_back"] forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    [self.navigationController.navigationBar setTintColor:DEF_NAVITEMCOLOR];
}
@end
