//
//  DFWT_RegisterController.m
//  DFWTProject
//
//  Created by Administrator on 2022/8/23.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_RegisterController.h"
#import "DFWT_CodeController.h"
#import <BEMCheckBox/BEMCheckBox.h>

@interface DFWT_RegisterController ()
@property (weak, nonatomic) IBOutlet UIView *countryCode;
@property (weak, nonatomic) IBOutlet UILabel *countryLb;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;

@end

@implementation DFWT_RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
- (void)setUI{
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 6;
    [self.phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.phoneTF.maxLength = 11;
    
    [self.codeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.codeTF.maxLength = 6;
    
    [self.pwdTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.pwdTF.maxLength = 20;
    self.pwdTF.secureTextEntry = YES;
    
    self.sendCodeBtn.layer.cornerRadius = 4;
    self.sendCodeBtn.layer.masksToBounds = YES;
    self.sendCodeBtn.layer.borderWidth = 1;
    self.sendCodeBtn.layer.borderColor = DEF_HEXColor(0x868686).CGColor;
    
    self.checkBox.boxType = BEMBoxTypeSquare;
    //添加手势
    DEF_WeakSelf(self)
    [self.countryCode setTapActionWithBlock:^{
        [weakSelf selectcCode];
    }];
}

//发送验证码
- (IBAction)sendCodeAction:(UIButton *)sender {
    if ([NSString isBlankString:self.phoneTF.text]) {
        [self showHUDMessage:@"请输入手机号"];
    }else if (![self.phoneTF.text isPhoneNumber]) {
        [self showHUDMessage:@"请输入正确的手机号"];
    }else{
        [self requestCode];
    }
}

//发送验证码接口
-(void)requestCode{
    self.sendCodeBtn.layer.borderWidth = 0;
    self.sendCodeBtn.titleEdgeInsets = UIEdgeInsetsZero;
    [self.sendCodeBtn countDownWithTime:60 withTitle:@"获取验证码" andCountDownTitle:@"后重新发送" countDoneBlock:^(UIButton * _Nonnull button) {
        self.sendCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 12);
        self.sendCodeBtn.layer.borderWidth = 1;
    } isInteraction:NO];
}

//注册
- (IBAction)registerAction:(UIButton *)sender {
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
   if ((self.phoneTF.text.length == 11 && self.pwdTF.text.length >= 8 && self.codeTF.text.length >= 4)) {
          self.registerBtn.backgroundColor = DEF_HEXAColor(0x0077FF, 1);
          self.registerBtn.userInteractionEnabled = YES;
      }else{
          self.registerBtn.backgroundColor = DEF_HEXAColor(0x0077FF, 0.2);
          self.registerBtn.userInteractionEnabled = NO;
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
