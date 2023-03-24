//
//  DFWT_EmployeeSocialInfoView.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/3.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_EmployeeSocialInfoView.h"
#import <UFKit/UFKit.h>
@interface DFWT_EmployeeSocialInfoView()
@property (nonatomic,strong)UFFormView *formView;
@property (nonatomic,copy)NSString *cardinalType;
@end
@implementation DFWT_EmployeeSocialInfoView

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
                            .width(120)
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
                // 添加参保日期
                    .addRow([UFDatePickerRow makeDatePickerRow:^(UFDatePickerRowMaker * _Nonnull make) {
                        make
                            .maximumDate([NSDate date])
                            .datePickerMode(UIDatePickerModeDate)
                            .dateFormat(@"yyyy-MM-dd")
                            .title(@"参保日期")
                            .name(@"entryTime")
                            .value(weakSelf.model.InsuredDate)
                            .accessoryType(UFRowAccessoryDisclosureIndicator)
                            .valueDidChanged(^(__kindof UFRow * _Nonnull row, NSString * _Nonnull value) {
                                
                            });
                    }])
                // 添加参保状态
                    .addRow([UFPickerViewRow makePickerViewRow:^(UFPickerViewRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"在职参保",@"停缴"])
                            .title(@"参保状态")
                            .value(weakSelf.model.InsuredStatus)
                            .name(@"InsuredStatus")
                            .accessoryType(UFRowAccessoryDisclosureIndicator);
                    }])
                // 添加养老账号
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeNumbers)
                            .title(@"养老账号")
                            .value(weakSelf.model.yanglaoNumber)
                            .name(@"yanglaoNumber")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加医疗账号
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeNumbers)
                            .title(@"医疗账号")
                            .value(weakSelf.model.yiliaoNumber)
                            .name(@"yiliaoNumber")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加工伤账号
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeNumbers)
                            .title(@"工伤账号")
                            .value(weakSelf.model.gongshangNumber)
                            .name(@"gongshangNumber")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加失业账号
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeNumbers)
                            .title(@"失业账号")
                            .value(weakSelf.model.shiyeNumber)
                            .name(@"shiyeNumber")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加公积金账号
                    .addRow([UFTextFieldRow makeTextFieldRow:^(UFTextFieldRowMaker * _Nonnull make) {
                        make
                            .limitType(UFInputLimitTypeNumbers)
                            .title(@"公积金账号")
                            .value(weakSelf.model.gongjijinNumber)
                            .name(@"gongjijinNumber")
                            .accessoryType(UFRowAccessoryNone);
                    }])
                // 添加社保基数类型
                    .addRow([UFPickerViewRow makePickerViewRow:^(UFPickerViewRowMaker * _Nonnull make) {
                        make
                            .itemArray(@[@"最高",@"最低",@"工资"])
                            .title(@"社保基数类型")
                            .value(weakSelf.model.cardinalType)
                            .name(@"InsuredStatus")
                            .accessoryType(UFRowAccessoryDisclosureIndicator)
                            .valueDidChanged(^(__kindof UFRow * _Nonnull row, NSString * _Nonnull value) {
                                weakSelf.cardinalType = row.value;
                                if (weakSelf.typeBlock) {
                                    weakSelf.typeBlock(weakSelf.cardinalType);
                                }
                            });
                    }])
                // 添加详情
                    .addRow([UFRow makeRow:^(UFRowMaker * _Nonnull make) {
                        make
                            .title(@"缴费基数明细表")
                            .accessoryType(UFRowAccessoryDisclosureIndicator)
                            .value(@"点击查看")
                            .rowDidSelected(^(__kindof UFRow * _Nonnull row) {
                                if (weakSelf.clickBlock) {
                                    weakSelf.clickBlock();
                                }
                            });
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

- (void)setModel:(DFWT_EmployeeSocialInfoModel *)model{
    _model = model;
    [self setUI];
    [self.formView reloadData];
    self.cardinalType = model.cardinalType;
}
@end
