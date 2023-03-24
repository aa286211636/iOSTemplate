//
//  DFWT_EmployeeBasicInfoView.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/2.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_EmployeeBasicInfoView.h"
#import <UFKit/UFKit.h>
@interface DFWT_EmployeeBasicInfoView()
@property (nonatomic,strong)UFFormView *formView;
@end
@implementation DFWT_EmployeeBasicInfoView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    DEF_WeakSelf(self)
    self.formView = [UFFormView makeFormView:^(UFFormViewMaker * _Nonnull make) {
        make
            .rowHeight(50)
            .rowEdgeInsets(UIEdgeInsetsMake(15, 15, 15, 15))
            .addSection([UFSection makeSection:^(UFSectionMaker * _Nonnull make) {
                make
                // 标题样式设置
                    .titleStyle([UFRowTitleStyle makeTitleStyle:^(UFRowTitleStyleMaker * _Nonnull make) {
                        make
                            .width(100)
                            .color([UIColor ufk_titleColor])
                            .font([UIFont systemFontOfSize:15])
                            .textAlignment(NSTextAlignmentLeft);
                    }])
                
                // 值样式设置
                    .valueStyle([UFTextStyle makeTextStyle:^(UFRowTextStyleMaker * _Nonnull make) {
                        make
                            .font([UIFont systemFontOfSize:15])
                            .color([UIColor ufk_titleColor])
                            .textAlignment(NSTextAlignmentRight);
                    }])
                
                // 添加姓名
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"姓名")
                            .isRequired(YES)
                            .value(weakSelf.model.Name)
                            .name(@"Name")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加英文名
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"英文名")
                            .value(weakSelf.model.englishName)
                            .name(@"englishName")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加联系方式
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeMobile)
                            .isRequired(YES)
                            .title(@"联系方式")
                            .value(weakSelf.model.telephone)
                            .name(@"telephone")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加民族
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .maxLength(5)
                            .title(@"民族")
                            .value(weakSelf.model.nation)
                            .name(@"nation")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加证件类型
                    .addRow([UFPickerViewRow makePickerViewRow:^(UFPickerViewRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"身份证",@"护照"])
                            .title(@"证件类型")
                            .value(weakSelf.model.certificateType)
                            .name(@"certificateType")
                            .accessoryType(UFRowAccessoryDisclosureIndicator);
                    }])
                // 添加证件号码
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeIdCard)
                            .title(@"证件号码")
                            .value(weakSelf.model.certificateNumber)
                            .name(@"certificateNumber")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加出生日期
                    .addRow([UFDatePickerRow makeDatePickerRow:^(UFDatePickerRowMaker * _Nonnull make) {
                        make
                            .maximumDate([NSDate date])
                            .datePickerMode(UIDatePickerModeDate)
                            .dateFormat(@"yyyy-MM-dd")
                            .title(@"出生日期")
                            .name(@"birthday")
                            .value(weakSelf.model.brithDay)
                            .accessoryType(UFRowAccessoryDisclosureIndicator)
                            .valueDidChanged(^(__kindof UFRow * _Nonnull row, NSString * _Nonnull value) {
                    
                            });
                    }])
                // 添加年龄
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .maxLength(2)
                            .limitType(UFInputLimitTypeNumbers)
                            .title(@"年龄")
                            .value(weakSelf.model.age)
                            .name(@"age")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加性别
                    .addRow([UFRadioGroupRow makeRadioGroupRow:^(UFRadioGroupRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"男",@"女"])
                            .title(@"性别")
                            .value(weakSelf.model.sex)
                            .name(@"sex")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加员工状态
                    .addRow([UFPickerViewRow makePickerViewRow:^(UFPickerViewRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"在职",@"离职"])
                            .title(@"员工状态")
                            .value(weakSelf.model.status)
                            .name(@"status")
                            .accessoryType(UFRowAccessoryDisclosureIndicator);
                    }])
                // 添加现居住地
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"现居住地")
                            .value(weakSelf.model.currentHabitation)
                            .name(@"currentHabitation")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加户籍地
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"户籍地")
                            .value(weakSelf.model.householdRegistrationNature)
                            .name(@"householdRegistrationNature")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加户口性质
                    .addRow([UFPickerViewRow makePickerViewRow:^(UFPickerViewRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"城镇",@"农村"])
                            .title(@"户口性质")
                            .value(weakSelf.model.registeredResidenc)
                            .name(@"registeredResidenc")
                            .accessoryType(UFRowAccessoryDisclosureIndicator);
                    }])
                // 添加婚姻状况
                    .addRow([UFPickerViewRow makePickerViewRow:^(UFPickerViewRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"已婚",@"未婚",@"离异"])
                            .title(@"婚姻状况")
                            .value(weakSelf.model.maritalStatus)
                            .name(@"maritalStatus")
                            .accessoryType(UFRowAccessoryDisclosureIndicator);
                    }])
                // 添加银行卡号
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeNumbers)
                            .title(@"银行卡号")
                            .value(weakSelf.model.bankCardNumber)
                            .name(@"bankCardNumber")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加毕业院校
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"毕业院校")
                            .value(weakSelf.model.graduationSchool)
                            .name(@"graduationSchool")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加毕业时间
                    .addRow([UFDatePickerRow makeDatePickerRow:^(UFDatePickerRowMaker * _Nonnull make) {
                        make
                            .maximumDate([NSDate date])
                            .datePickerMode(UIDatePickerModeDate)
                            .dateFormat(@"yyyy-MM-dd")
                            .title(@"毕业时间")
                            .name(@"graduationTim")
                            .value(weakSelf.model.graduationTim)
                            .accessoryType(UFRowAccessoryDisclosureIndicator)
                            .valueDidChanged(^(__kindof UFRow * _Nonnull row, NSString * _Nonnull value) {
                    
                            });
                    }])
                // 添加学历
                    .addRow([UFPickerViewRow makePickerViewRow:^(UFPickerViewRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"博士",@"硕士",@"本科",@"大专"])
                            .title(@"学历")
                            .value(weakSelf.model.education)
                            .name(@"education")
                            .accessoryType(UFRowAccessoryDisclosureIndicator);
                    }])
                // 添加QQ
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeNumbers)
                            .title(@"QQ")
                            .value(weakSelf.model.qq)
                            .name(@"qq")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加邮箱
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"专业")
                            .value(weakSelf.model.major)
                            .name(@"major")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加紧急联系人
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"紧急联系人")
                            .value(weakSelf.model.emergencyContact)
                            .name(@"emergencyContact")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加联系人国籍
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"联系人国籍")
                            .value(weakSelf.model.contactNation)
                            .name(@"contactNation")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加联系人电话
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .maxLength(11)
                            .limitType(UFInputLimitTypeMobile)
                            .title(@"联系人电话")
                            .value(weakSelf.model.contactTelephone)
                            .name(@"contactTelephone")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加兴趣爱好
                    .addRow([UFTextViewRow makeTextViewRow:^(UFTextViewRowMaker * _Nonnull make) {
                        make
                            .title(@"兴趣爱好")
                            .value(weakSelf.model.hobby)
                            .name(@"hobby")
                            .accessoryType(UFRowAccessoryNone)
                            .height(100);
                    }])
                // 添加多行备注
                    .addRow([UFTextViewRow makeTextViewRow:^(UFTextViewRowMaker * _Nonnull make) {
                        make
                            .title(@"备注")
                            .value(weakSelf.model.remark)
                            .name(@"remark")
                            .accessoryType(UFRowAccessoryNone)
                            .height(100);
                    }]);
            }])
        
        // 添加提交按钮
            .addSubmitButton([UFActionButton makeActionButton:^(UFActionButtonMaker * _Nonnull make) {
                make
                    .titleForState(@"保存", UIControlStateNormal)
                    .titleColorForState([UIColor whiteColor], UIControlStateNormal)
                    .cornerRadius(17)
                    .backgroundColor([UIColor redColor])
                    .actionButtonClick(^(UFActionButton * _Nonnull button) {
                        DEF_Log(@"提交的信息：\n%@",[weakSelf.formView toDictionary]);
                    });
            }])
            .addToSuperView(self);
    }];
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setModel:(DFWT_EmployeeInfoModel *)model{
    _model = model;
    [self setUI];
    [self.formView reloadData];
}
@end
