//
//  IMYAppGrayStyle.h
//  DFWTProject
//
//  Created by Administrator on 2022/12/7.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMYAppGrayStyle : NSObject
/// 开启全局变灰

+ (void)open;

/// 关闭全局变灰

+ (void)close;

/// 添加灰色模式

+ (void)addToView:(UIView *)view;

/// 移除灰色模式

+ (void)removeFromView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
