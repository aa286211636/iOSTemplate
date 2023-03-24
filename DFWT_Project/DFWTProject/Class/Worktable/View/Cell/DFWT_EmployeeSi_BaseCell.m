//
//  DFWT_EmployeeSi_BaseCell.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/6.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_EmployeeSi_BaseCell.h"
@interface DFWT_EmployeeSi_BaseCell()
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *JFJSLb;
@property (weak, nonatomic) IBOutlet UILabel *DWBLLb;
@property (weak, nonatomic) IBOutlet UILabel *GRBLLb;
@property (weak, nonatomic) IBOutlet UILabel *DWJELb;
@property (weak, nonatomic) IBOutlet UILabel *GRJELb;

@end
@implementation DFWT_EmployeeSi_BaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setHiddenLine:(BOOL)hiddenLine{
    _hiddenLine = hiddenLine;
    self.bottomLine.hidden = hiddenLine;
}

-(void)setModel:(DFWT_EmployeeSocialBaseModel *)model{
    _model = model;
    self.nameLb.text = model.SocialInsuranceName;
    self.JFJSLb.text = model.paymentBase;
    self.DWBLLb.text = model.unitPaymentProportion;
    self.GRBLLb.text = model.individualPaymentProportion;
    self.DWJELb.text = model.unitPaymentAmount;
    self.GRJELb.text = model.individualPaymentAmount;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
