//
//  DFWT_EmployeeCell.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/2.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_EmployeeCell.h"
@interface DFWT_EmployeeCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *departLb;
@property (weak, nonatomic) IBOutlet UILabel *positionLb;
@property (weak, nonatomic) IBOutlet UILabel *numberLb;

@end
@implementation DFWT_EmployeeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgV.layer.masksToBounds = YES;
    self.headImgV.layer.cornerRadius = 30;
}

-(void)setModel:(DFWT_EmployeeInfoModel *)model{
    [self.headImgV setImageWithString:model.Name];
    self.nameLb.text = [NSString stringWithFormat:@"姓名：%@",model.Name];
    self.departLb.text = [NSString stringWithFormat:@"部门：%@",model.deptName];
    self.numberLb.text = [NSString stringWithFormat:@"NO.%@",model.employeeID];
    self.positionLb.text = [NSString stringWithFormat:@"岗位：%@",model.positionName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
