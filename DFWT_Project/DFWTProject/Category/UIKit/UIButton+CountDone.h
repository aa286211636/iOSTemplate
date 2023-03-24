//
//  UIButton+CountDone.h
//
//  Created by Administrator on 2021/4/13.
//  Copyright © 2021 Administrator. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CountDoneBlock)(UIButton *button);
@interface UIButton (CountDown)
- (void)countDownWithTime:(NSInteger)timeLine withTitle:(NSString *)title andCountDownTitle:(NSString *)subTitle countDoneBlock:(CountDoneBlock)countDoneBlock isInteraction:(BOOL)isInteraction;

@end

NS_ASSUME_NONNULL_END
