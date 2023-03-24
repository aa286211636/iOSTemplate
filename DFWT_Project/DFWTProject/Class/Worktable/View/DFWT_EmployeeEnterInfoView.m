//
//  DFWT_EmployeeEnterInfoView.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/3.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_EmployeeEnterInfoView.h"
#import <UFKit/UFKit.h>
@interface DFWT_EmployeeEnterInfoView()
@property (nonatomic,strong)UFFormView *formView;
@end
@implementation DFWT_EmployeeEnterInfoView

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
                // 添加员工类型
                    .addRow([UFPickerViewRow makePickerViewRow:^(UFPickerViewRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"试用期员工",@"正式员工",@"实习期"])
                            .title(@"员工类型")
                            .value(weakSelf.model.employeeType)
                            .name(@"employeeType")
                            .accessoryType(UFRowAccessoryDisclosureIndicator);
                    }])
                // 添加入职时间
                    .addRow([UFDatePickerRow makeDatePickerRow:^(UFDatePickerRowMaker * _Nonnull make) {
                        make
                            .maximumDate([NSDate date])
                            .datePickerMode(UIDatePickerModeDate)
                            .dateFormat(@"yyyy-MM-dd")
                            .title(@"入职时间")
                            .name(@"entryTime")
                            .isRequired(YES)
                            .value(weakSelf.model.entryTime)
                            .accessoryType(UFRowAccessoryDisclosureIndicator)
                            .valueDidChanged(^(__kindof UFRow * _Nonnull row, NSString * _Nonnull value) {
                                
                            });
                    }])
                // 添加员工工号
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeNumbers)
                            .isRequired(YES)
                            .title(@"员工工号")
                            .value(weakSelf.model.employeeID)
                            .name(@"employeeID")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加部门
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .isRequired(YES)
                            .title(@"部门")
                            .value(weakSelf.model.deptName)
                            .ext(weakSelf.model.deptId)
                            .name(@"deptName")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加岗位
                    .addRow([UFPickerViewRow makePickerViewRow:^(UFPickerViewRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"开发岗",@".NET",@"架构师",@"人事",@"产品经理",@"JAVA开发工程师",@"前端岗",@"运维岗"])
                            .title(@"岗位")
                            .isRequired(YES)
                            .value(weakSelf.model.positionName)
                            .name(@"positionName")
                            .accessoryType(UFRowAccessoryDisclosureIndicator);
                    }])
                // 添加工作地点
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"工作地点")
                            .value(weakSelf.model.workAddress)
                            .name(@"workAddress")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加试用期
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .title(@"试用期")
                            .value(weakSelf.model.probationPeriod)
                            .name(@"probationPeriod")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加转正时间
                    .addRow([UFDatePickerRow makeDatePickerRow:^(UFDatePickerRowMaker * _Nonnull make) {
                        make
                            .datePickerMode(UIDatePickerModeDate)
                            .dateFormat(@"yyyy-MM-dd")
                            .title(@"转正时间")
                            .name(@"chageDate")
                            .value(weakSelf.model.chageDate)
                            .accessoryType(UFRowAccessoryDisclosureIndicator)
                            .valueDidChanged(^(__kindof UFRow * _Nonnull row, NSString * _Nonnull value) {
                                
                            });
                    }])
                // 添加试用期薪资
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeMoney)
                            .title(@"试用期薪资")
                            .value(weakSelf.model.probationSalary)
                            .name(@"probationSalary")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加转正基本薪资
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeMoney)
                            .title(@"转正基本工资")
                            .value(weakSelf.model.basicSalary)
                            .name(@"basicSalary")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加转正岗位薪资
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeMoney)
                            .title(@"转正岗位工资")
                            .value(weakSelf.model.postSalary)
                            .name(@"postSalary")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加绩效工资
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeMoney)
                            .title(@"绩效工资")
                            .value(weakSelf.model.achievementsSalary)
                            .name(@"achievementsSalary")
                            .accessoryType(UFRowAccessoryNone);
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

- (void)setModel:(DFWT_EmployeeEnterInfoModel *)model{
    _model = model;
    [self setUI];
    [self.formView reloadData];
}
@end
