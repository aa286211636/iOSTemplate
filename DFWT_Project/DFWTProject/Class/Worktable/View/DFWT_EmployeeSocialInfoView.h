//
//  DFWT_EmployeeSocialInfoView.h
//  DFWTProject
//
//  Created by Administrator on 2023/3/3.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFWT_EmployeeSocialModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(void);
typedef void(^TypeBlock)(NSString *type);
@interface DFWT_EmployeeSocialInfoView : UIView
@property (nonatomic,strong)DFWT_EmployeeSocialInfoModel *model;
@property (nonatomic,copy) ClickBlock clickBlock;
@property (nonatomic,copy) TypeBlock typeBlock;

@end

NS_ASSUME_NONNULL_END
