//
//  DFWT_EmployeeModel.h
//  DFWTProject
//
//  Created by Administrator on 2023/3/2.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFWT_EmployeeInfoModel : BaseModel
@property (nonatomic,copy) NSString *Name;
@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString *bankCardNumber;
@property (nonatomic,copy) NSString *brithDay;
@property (nonatomic,copy) NSString *certificateNumber;
@property (nonatomic,copy) NSString *certificateType;
@property (nonatomic,copy) NSString *contactNation;
@property (nonatomic,copy) NSString *contactTelephone;
@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString *createName;
@property (nonatomic,copy) NSString *createOrgCode;
@property (nonatomic,copy) NSString *createOrgId;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *createUserId;
@property (nonatomic,copy) NSString *createUserName;
@property (nonatomic,copy) NSString *creatorId;
@property (nonatomic,copy) NSString *currentHabitation;
@property (nonatomic,assign) BOOL deleted;
@property (nonatomic,copy) NSString *deptId;
@property (nonatomic,copy) NSString *deptName;
@property (nonatomic,copy) NSString *education;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *emergencyContact;
@property (nonatomic,copy) NSString *employeeID;
@property (nonatomic,copy) NSString *employeeType;
@property (nonatomic,copy) NSString *englishName;
@property (nonatomic,copy) NSString *entryTime;
@property (nonatomic,copy) NSString *file;
@property (nonatomic,copy) NSString *fillFormDate;
@property (nonatomic,copy) NSString *graduationSchool;
@property (nonatomic,copy) NSString *graduationTim;
@property (nonatomic,copy) NSString *hobby;
@property (nonatomic,copy) NSString *householdRegistrationNature;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *major;
@property (nonatomic,copy) NSString *maritalStatus;
@property (nonatomic,copy) NSString *nation;
@property (nonatomic,assign) NSInteger pageNum;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,copy) NSString *positionId;
@property (nonatomic,copy) NSString *positionName;
@property (nonatomic,copy) NSString *qq;
@property (nonatomic,copy) NSString *registeredResidenc;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *staffNum;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *telephone;
@property (nonatomic,copy) NSString *tenantId;
@property (nonatomic,copy) NSString *updateUserId;
@property (nonatomic,copy) NSString *updateUserName;
@end

@interface DFWT_EmployeeModel : BaseModel
@property (nonatomic,assign) NSInteger code;//响应编码
@property (nonatomic,copy) NSString *msg;//错误信息
@property (nonatomic,strong) id ext;
@property (nonatomic,assign) NSInteger total;//分页记录总数
@property (nonatomic,strong) NSArray <DFWT_EmployeeInfoModel *>* data;
@end

NS_ASSUME_NONNULL_END
