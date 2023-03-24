//
//  DFWT_HREmployeeInfoController.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/2.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_HREmployeeInfoController.h"
#import "DFWT_EmployeeSiBaseListController.h"
#import "CustomSegmentView.h"
#import "DFWT_EmployeeBasicInfoView.h"
#import "DFWT_EmployeeEnterInfoView.h"
#import "DFWT_EmployeeSocialInfoView.h"
#import "DFWT_EmployeeEnterModel.h"
#import "DFWT_EmployeeSocialModel.h"
@interface DFWT_HREmployeeInfoController ()
@property (nonatomic,strong)CustomSegmentView *segment;
@property (nonatomic,strong)DFWT_EmployeeBasicInfoView *basicInfoView;
@property (nonatomic,strong)DFWT_EmployeeEnterInfoView *enterInfoView;
@property (nonatomic,strong)DFWT_EmployeeSocialInfoView *socialInfoView;
@property(nonatomic,copy)NSString *cardinalType;
@end

@implementation DFWT_HREmployeeInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
    [self requestEnterInfo];
    [self requestSocialInfo];

}

//初始化
- (void)setUI{
    self.navigationItem.title = [NSString stringWithFormat:@"%@的员工信息",self.model.Name];
    [self.view addSubview:self.segment];
    self.cardinalType = @"";
    self.basicInfoView = [[DFWT_EmployeeBasicInfoView alloc]init];
    self.basicInfoView.model = self.model;
    [self.view addSubview:self.basicInfoView];
    self.enterInfoView = [[DFWT_EmployeeEnterInfoView alloc]init];
    [self.view addSubview:self.enterInfoView];
    self.socialInfoView = [[DFWT_EmployeeSocialInfoView alloc]init];
    DEF_WeakSelf(self)
    self.socialInfoView.clickBlock = ^{
        DFWT_EmployeeSiBaseListController* vc = [[DFWT_EmployeeSiBaseListController alloc]init];
        vc.cardinalType = weakSelf.cardinalType;
        [weakSelf.navigationController pushViewController:vc animated:NO];
    };
    self.socialInfoView.typeBlock = ^(NSString * _Nonnull type) {
        weakSelf.cardinalType = type;
    };
    [self.view addSubview:self.socialInfoView];

    [self.segment selectedAtIndex:^(NSUInteger index, UIButton * _Nonnull button) {
        if (index == 0) {
            weakSelf.basicInfoView.hidden = NO;
            weakSelf.enterInfoView.hidden = weakSelf.socialInfoView.hidden = YES;
        }else if (index == 1) {
            weakSelf.enterInfoView.hidden = NO;
            weakSelf.basicInfoView.hidden = weakSelf.socialInfoView.hidden = YES;
        }else if (index == 2) {
            weakSelf.socialInfoView.hidden = NO;
            weakSelf.enterInfoView.hidden = weakSelf.basicInfoView.hidden = YES;
        }
    }];
    [self.segment setSelectedAtIndex:0];
}

-(void)setLayout{
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.basicInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-DEF_SafeBotoomH);
        make.top.equalTo(self.segment.mas_bottom);
    }];
    [self.enterInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-DEF_SafeBotoomH);
        make.top.equalTo(self.segment.mas_bottom);
    }];
    [self.socialInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-DEF_SafeBotoomH);
        make.top.equalTo(self.segment.mas_bottom);
    }];
}

- (void)requestEnterInfo{
    DEF_WeakSelf(self)
    [self showHUD];
    [DFWT_EmployeeEnterModel fetchDataConfigure:^(NSDictionary *__autoreleasing *arguments, NSString *__autoreleasing *requestUrl, ApiRequestMethod *requestMethod, BOOL *MD5Encryption, NSDictionary *__autoreleasing *HTTPHeaders) {
        *HTTPHeaders = @{@"Content-Type":@"application/json;charset=UTF-8"};
        *arguments = @{@"employeeBasicInformationId":self.model.ID};
        *requestUrl = [NSString stringWithFormat:@"%@%@",BASEURL_Login,API_BasicInformation_EnterInfo];
        *requestMethod  = ApiRequestMethodPOSTBody;
        *MD5Encryption = NO;
    } complate:^(BOOL finished, NSDictionary *jsonObject, id resultModel, NSError *error) {
        DEF_StrongSelf(weakSelf)
        [strongSelf hideHUD];
        if (error) {
            [strongSelf showHUDMessage:@"服务器连接失败"];
            return ;
        }
        DFWT_EmployeeEnterModel *model = resultModel;
        if (model.code  == 0) {
            strongSelf.enterInfoView.model = model.data;
        }else{
            [strongSelf showHUDMessage:model.msg];
        }
    }];
}

- (void)requestSocialInfo{
    DEF_WeakSelf(self)
    [self showHUD];
    [DFWT_EmployeeSocialModel fetchDataConfigure:^(NSDictionary *__autoreleasing *arguments, NSString *__autoreleasing *requestUrl, ApiRequestMethod *requestMethod, BOOL *MD5Encryption, NSDictionary *__autoreleasing *HTTPHeaders) {
        *HTTPHeaders = @{@"Content-Type":@"application/json;charset=UTF-8"};
        *arguments = @{@"employeeBasicInformationId":self.model.ID};
        *requestUrl = [NSString stringWithFormat:@"%@%@",BASEURL_Login,API_BasicInformation_SocialInfo];
        *requestMethod  = ApiRequestMethodPOSTBody;
        *MD5Encryption = NO;
    } complate:^(BOOL finished, NSDictionary *jsonObject, id resultModel, NSError *error) {
        DEF_StrongSelf(weakSelf)
        [strongSelf hideHUD];
        if (error) {
            [strongSelf showHUDMessage:@"服务器连接失败"];
            return ;
        }
        DFWT_EmployeeSocialModel *model = resultModel;
        if (model.code  == 0) {
            DFWT_EmployeeSocialInfoModel *infoModel = model.data;
            strongSelf.socialInfoView.model = infoModel;
            strongSelf.cardinalType = infoModel.cardinalType;
        }else{
            [strongSelf showHUDMessage:model.msg];
        }
    }];
}

//懒加载
- (CustomSegmentView *)segment{
    if (!_segment) {
        _segment = [[CustomSegmentView alloc]initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, 0) titles:@[@"基本信息",@"入职信息",@"社保信息"]];
        _segment.backgroundColor = [UIColor whiteColor];
        _segment.segmentNormalColor = DEF_HEXColor(0x4E4F58);
        _segment.segmentTintColor = DEF_APPCOLOR;
        _segment.indicateColor = DEF_APPCOLOR;
    }
    return _segment;
}
@end
