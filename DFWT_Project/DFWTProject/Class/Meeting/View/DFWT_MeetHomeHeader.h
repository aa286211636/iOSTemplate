//
//  DFWT_MeetHomeHeader.h
//  DFWTProject
//
//  Created by Administrator on 2022/10/28.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DFWT_MeetHomeHeader;
@protocol DFWT_MeetHomeHeaderDelegate <NSObject>
//发起会议
-(void)DFWT_MeetHomeHeaderStartMeeting:(DFWT_MeetHomeHeader *)header;
//加入会议
-(void)DFWT_MeetHomeHeaderJoinMeeting:(DFWT_MeetHomeHeader *)header;
//预约会议
-(void)DFWT_MeetHomeHeaderOrderMeeting:(DFWT_MeetHomeHeader *)header;
//共享桌面
-(void)DFWT_MeetHomeHeaderShareDesktop:(DFWT_MeetHomeHeader *)header;

@end

@interface DFWT_MeetHomeHeader : UIView
@property (nonatomic,weak) id <DFWT_MeetHomeHeaderDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
