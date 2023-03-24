//
//  DFWT_EmployeeEnterModel.h
//  DFWTProject
//
//  Created by Administrator on 2023/3/3.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFWT_EmployeeEnterInfoModel : BaseModel
@property (nonatomic,copy) NSString *Name;
@property (nonatomic,copy) NSString *achievementsSalary;
@property (nonatomic,copy) NSString *basicSalary;
@property (nonatomic,copy) NSString *chageDate;
@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString *createName;
@property (nonatomic,copy) NSString *createOrgCode;
@property (nonatomic,copy) NSString *createOrgId;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *createUserId;
@property (nonatomic,copy) NSString *createUserName;
@property (nonatomic,copy) NSString *creatorId;
@property (nonatomic,assign) BOOL deleted;
@property (nonatomic,copy) NSString *deptId;
@property (nonatomic,copy) NSString *deptName;
@property (nonatomic,copy) NSString *employeeBasicInformationId;
@property (nonatomic,copy) NSString *employeeBasicInformationName;
@property (nonatomic,copy) NSString *employeeID;
@property (nonatomic,copy) NSString *employeeType;
@property (nonatomic,copy) NSString *entryTime;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *positionId;
@property (nonatomic,copy) NSString *positionName;
@property (nonatomic,copy) NSString *postGrade;
@property (nonatomic,copy) NSString *postSalary;
@property (nonatomic,copy) NSString *probationPeriod;
@property (nonatomic,copy) NSString *probationSalary;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *tenantId;
@property (nonatomic,copy) NSString *updateUserId;
@property (nonatomic,copy) NSString *updateUserName;
@property (nonatomic,copy) NSString *workAddress;
@end

@interface DFWT_EmployeeEnterModel : BaseModel
@property (nonatomic,assign) NSInteger code;//响应编码
@property (nonatomic,copy) NSString *msg;//错误信息
@property (nonatomic,strong) id ext;
@property (nonatomic,strong) DFWT_EmployeeEnterInfoModel* data;
@end

NS_ASSUME_NONNULL_END
