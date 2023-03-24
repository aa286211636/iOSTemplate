//
//  BaseRequestModel.h
//  ZYYLProject
//
//  Created by Administrator on 2021/4/26.
//  Copyright © 2021 Administrator. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseRequestModel : BaseModel

@property (nonatomic,assign) NSInteger code;//响应编码
@property (nonatomic,copy) NSString *msg;//错误信息
@property (nonatomic,strong) id ext;
@property (nonatomic,assign) NSInteger total;//分页记录总数
@property (nonatomic,strong) id data;
@end

NS_ASSUME_NONNULL_END
