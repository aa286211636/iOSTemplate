//
//  DFWT_EmployeeSocialModel.h
//  DFWTProject
//
//  Created by Administrator on 2023/3/3.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFWT_EmployeeSocialBaseModel : BaseModel
@property (nonatomic,copy) NSString *EmployeeBasicInformationId;
@property (nonatomic,copy) NSString *EmployeeBasicInformationName;
@property (nonatomic,copy) NSString *Name;
@property (nonatomic,copy) NSString *SocialInsuranceId;
@property (nonatomic,copy) NSString *SocialInsuranceName;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *individualPaymentAmount;
@property (nonatomic,copy) NSString *individualPaymentProportion;
@property (nonatomic,copy) NSString *paymentBase;
@property (nonatomic,copy) NSString *unitPaymentAmount;
@property (nonatomic,copy) NSString *unitPaymentProportion;

@end

@interface DFWT_EmployeeSocialInfoModel : BaseModel
@property (nonatomic,copy) NSString *InsuredDate;
@property (nonatomic,copy) NSString *InsuredStatus;
@property (nonatomic,copy) NSString *cardinalType;
@property (nonatomic,copy) NSString *employeeBasicInformationId;
@property (nonatomic,copy) NSString *employeeBasicInformationName;
@property (nonatomic,copy) NSString *gongjijinNumber;
@property (nonatomic,copy) NSString *gongshangNumber;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *shiyeNumber;
@property (nonatomic,copy) NSString *yanglaoNumber;
@property (nonatomic,copy) NSString *yiliaoNumber;
@property (nonatomic,strong) NSArray <DFWT_EmployeeSocialBaseModel *>* siBase;

@end

@interface DFWT_EmployeeSocialModel : BaseModel
@property (nonatomic,assign) NSInteger code;//响应编码
@property (nonatomic,copy) NSString *msg;//错误信息
@property (nonatomic,strong) id ext;
@property (nonatomic,strong) DFWT_EmployeeSocialInfoModel* data;
@end
NS_ASSUME_NONNULL_END
