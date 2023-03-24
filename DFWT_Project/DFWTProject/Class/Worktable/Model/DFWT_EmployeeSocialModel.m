//
//  DFWT_EmployeeSocialModel.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/3.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_EmployeeSocialModel.h"

@implementation DFWT_EmployeeSocialBaseModel

@end

@implementation DFWT_EmployeeSocialInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"siBase": [DFWT_EmployeeSocialBaseModel class]};
}
@end

@implementation DFWT_EmployeeSocialModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data": [DFWT_EmployeeSocialInfoModel class]};
}
@end
