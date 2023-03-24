//
//  DFWT_MsgCell.m
//  DFWTProject
//
//  Created by Administrator on 2022/9/7.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MsgCell.h"
#import "LFBadge.h"
@interface DFWT_MsgCell()
@property (strong, nonatomic) LFBadge *badgeView;

@end

@implementation DFWT_MsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.badgeView = [[LFBadge alloc] init];
    [self.badgeView addToView:self.contentView];
    self.badgeView.edgeInsets = UIEdgeInsetsMake(50, 0, 0, 30);
    self.badgeView.count = @"13";
    self.badgeView.needDisappearEffects = YES;
    self.badgeView.clearBlock = ^{
           NSLog(@"清除未读消息角标");
       };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
