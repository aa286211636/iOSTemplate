//
//  DFWT_MeetHomeHeader.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/28.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MeetHomeHeader.h"
#import "CustomSearchTextField.h"
@interface DFWT_MeetHomeHeader()

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet CustomSearchTextField *searchTF;
@property (weak, nonatomic) IBOutlet UIView *startMeetingView;
@property (weak, nonatomic) IBOutlet UIView *joinMeetingView;
@property (weak, nonatomic) IBOutlet UIView *orderMeetingView;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@end

@implementation DFWT_MeetHomeHeader

- (void)awakeFromNib{
    [super awakeFromNib];
    self.searchView.layer.cornerRadius = 4;
    self.searchView.layer.masksToBounds = YES;
    [self addGesture];
}

- (void)addGesture{
    DEF_WeakSelf(self)
    [self.startMeetingView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DFWT_MeetHomeHeaderStartMeeting:)]) {
            [weakSelf.delegate DFWT_MeetHomeHeaderStartMeeting:weakSelf];
        }
    }];
    [self.joinMeetingView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DFWT_MeetHomeHeaderJoinMeeting:)]) {
            [weakSelf.delegate DFWT_MeetHomeHeaderJoinMeeting:weakSelf];
        }
    }];
    [self.orderMeetingView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DFWT_MeetHomeHeaderStartMeeting:)]) {
            [weakSelf.delegate DFWT_MeetHomeHeaderOrderMeeting:weakSelf];
        }
    }];
    [self.shareView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(DFWT_MeetHomeHeaderStartMeeting:)]) {
        }
    }];
}
@end
