//
//  DFWT_EmployeeSi_BaseCell.h
//  DFWTProject
//
//  Created by Administrator on 2023/3/6.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFWT_EmployeeSocialModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFWT_EmployeeSi_BaseCell : UITableViewCell
@property (nonatomic,assign)BOOL hiddenLine;
@property(nonatomic,strong)DFWT_EmployeeSocialBaseModel *model;
@end

NS_ASSUME_NONNULL_END
