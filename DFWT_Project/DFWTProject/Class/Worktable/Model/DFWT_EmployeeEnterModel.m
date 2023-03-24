//
//  DFWT_EmployeeEnterModel.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/3.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_EmployeeEnterModel.h"

@implementation DFWT_EmployeeEnterInfoModel

@end


@implementation DFWT_EmployeeEnterModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data": [DFWT_EmployeeEnterInfoModel class]};
}
@end
