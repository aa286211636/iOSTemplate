//
//  DFWT_EmployeeModel.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/2.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_EmployeeModel.h"
@implementation DFWT_EmployeeInfoModel

@end


@implementation DFWT_EmployeeModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data": [DFWT_EmployeeInfoModel class]};
}
@end
