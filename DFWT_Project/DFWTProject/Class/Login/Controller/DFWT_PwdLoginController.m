//
//  DFWT_PwdLoginController.m
//  DFWTProject
//
//  Created by Administrator on 2022/8/23.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_PwdLoginController.h"
#import "DFWT_ResetPwdController.h"
#import "DFWT_CodeController.h"
#import <BEMCheckBox/BEMCheckBox.h>

@interface DFWT_PwdLoginController ()
@property (weak, nonatomic) IBOutlet UIView *countryCode;
@property (weak, nonatomic) IBOutlet UILabel *countryLb;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
@end

@implementation DFWT_PwdLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 6;
    [self.phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.phoneTF.maxLength = 11;

    [self.pwdTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.pwdTF.maxLength = 20;
    self.pwdTF.secureTextEntry = YES;
    
    self.checkBox.boxType = BEMBoxTypeSquare;
    //添加手势
    DEF_WeakSelf(self)
    [self.countryCode setTapActionWithBlock:^{
        [weakSelf selectcCode];
    }];
}
- (IBAction)findPwdAction:(UIButton *)sender {
    DFWT_ResetPwdController *vc = [[DFWT_ResetPwdController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (IBAction)loginAction:(UIButton *)sender {
    if (!self.checkBox.on) {
        [self showHUDMessage:@"请勾选《用户服务协议》与《隐私政策》"];
    }else if (![self.phoneTF.text isPhoneNumber]) {
        [self showHUDMessage:@"请输入正确的手机号"];
    }else if (self.pwdTF.text.length < 8){
        [self showHUDMessage:@"请输入8-20位密码"];
    }else{
       
    }
}


//选择国家编码
-(void)selectcCode{
    DFWT_CodeController *vc = [[DFWT_CodeController alloc]init];
    DEF_WeakSelf(self);
    vc.countryCodeBlock = ^(NSString * _Nonnull code) {
        weakSelf.countryLb.text = code;
    };
    [self.navigationController pushViewController:vc animated:NO];
}

//监听输入
- (void)textFieldDidChange:(UITextField *)textField {
   if ((self.phoneTF.text.length == 11 && self.pwdTF.text.length >= 8)) {
          self.loginBtn.backgroundColor = DEF_HEXAColor(0x0077FF, 1);
          self.loginBtn.userInteractionEnabled = YES;
      }else{
          self.loginBtn.backgroundColor = DEF_HEXAColor(0x0077FF, 0.2);
          self.loginBtn.userInteractionEnabled = NO;
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
