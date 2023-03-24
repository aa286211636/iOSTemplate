//
//  DFWT_AttendanceCell.h
//  DFWTProject
//
//  Created by Administrator on 2022/11/1.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFWT_AttendanceCell : UITableViewCell
@property (nonatomic,assign) BOOL isDone; //是否打卡完毕
@property (nonatomic,assign) BOOL isHideLine; //是否打卡完毕

@end

NS_ASSUME_NONNULL_END
