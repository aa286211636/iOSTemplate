//
//  UIView+Gesture.h
//  ZYYLProject
//
//  Created by Administrator on 2021/4/15.
//  Copyright © 2021 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Gesture)
- (void)setTapActionWithBlock:(void (^)(void))block;

- (void)setLongPressActionWithBlock:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
