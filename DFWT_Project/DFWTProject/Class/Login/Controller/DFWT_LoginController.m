//
//  DFWT_LoginController.m
//  DFWTProject
//
//  Created by Administrator on 2022/8/22.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_LoginController.h"
#import <BEMCheckBox/BEMCheckBox.h>
#import "DFWT_TabController.h"

@interface DFWT_LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *accoutTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;

@end

@implementation DFWT_LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 6;
    self.checkBox.boxType = BEMBoxTypeSquare;
    self.checkBox.on = YES;
    self.checkBox.onAnimationType = BEMAnimationTypeFade;
    //监听输入框
    [self.accoutTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //self.accoutTF.maxLength = 11;
}


-(void)requestLogin{
    DEF_WeakSelf(self)
    [self showHUD];
    [BaseRequestModel fetchDataConfigure:^(NSDictionary *__autoreleasing *arguments, NSString *__autoreleasing *requestUrl, ApiRequestMethod *requestMethod, BOOL *MD5Encryption, NSDictionary *__autoreleasing *HTTPHeaders) {
        *HTTPHeaders = @{@"Content-Type":@"application/json;charset=UTF-8"};
        *arguments = @{
            @"username":@"xdyhadmin",//weakSelf.accoutTF.text,
            @"password":@"Meta123$%^",//weakSelf.pwdTF.text,
            @"code":@""
        };
        *requestUrl = [NSString stringWithFormat:@"%@%@",BASEURL_Login,API_Login];
        *requestMethod  = ApiRequestMethodPOSTBody;
        *MD5Encryption = NO;
    } complate:^(BOOL finished, NSDictionary *jsonObject, id resultModel, NSError *error) {
        DEF_StrongSelf(weakSelf)
        [strongSelf hideHUD];
        if (error) {
            [strongSelf showHUDMessage:@"服务器连接失败"];
            return ;
        }
        BaseRequestModel *model = resultModel;
        if (model.code == 200) {
            [strongSelf showHUDMessage:@"登陆成功"];
            NSDictionary *dic = model.data;
            NSString *token = [dic objectForKey:@"access_token"];
            DEF_SaveUserDefault(token, @"TOKEN");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                DFWT_TabController *tab = [[DFWT_TabController alloc]init];
                [UIApplication sharedApplication].keyWindow.rootViewController = tab;
            });

          }else{
            [strongSelf showHUDMessage:model.msg];
        }
    }];
}

//监听输入
- (void)textFieldDidChange:(UITextField *)textField {
    if (self.accoutTF.text.length && self.pwdTF.text.length) {
        self.loginBtn.backgroundColor = DEF_HEXAColor(0x3F8CFF, 1);
        self.loginBtn.userInteractionEnabled = YES;
    }else{
        self.loginBtn.backgroundColor = DEF_HEXAColor(0x3F8CFF, 0.2);
        self.loginBtn.userInteractionEnabled = NO;

    }
}

- (IBAction)loginAction:(UIButton *)sender {
    if (!self.checkBox.on) {
        [self showHUDMessage:@"请勾选鑫元易联用户协议与隐私政策"];
    }else{
        [self requestLogin];
    }
}

//用户服务协议
- (IBAction)YHFWAction:(UIButton *)sender {
}
//隐私政策
- (IBAction)YSZCAction:(UIButton *)sender {
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
