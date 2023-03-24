//
//  DFWT_AddressbookHeader.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/25.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_AddressbookHeader.h"
@interface DFWT_AddressbookHeader()
@property (weak, nonatomic) IBOutlet UIView *userAccessView;
@property (weak, nonatomic) IBOutlet UIView *organizationView;
@property (weak, nonatomic) IBOutlet UIView *outsideView;
@property (weak, nonatomic) IBOutlet UIView *friendsView;
@property (weak, nonatomic) IBOutlet UIView *applyView;
@property (weak, nonatomic) IBOutlet UIView *groupView;

@end

@implementation DFWT_AddressbookHeader

-(void)awakeFromNib{
    [super awakeFromNib];
    DEF_WeakSelf(self)
    [self.userAccessView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addressbookHeaderWithUserAccess:)]) {
            [weakSelf.delegate addressbookHeaderWithUserAccess:weakSelf];
        }
    }];
    [self.organizationView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addressbookHeaderWithOrganization:)]) {
            [weakSelf.delegate addressbookHeaderWithOrganization:weakSelf];
        }
    }];
    [self.outsideView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addressbookHeaderWithOutside:)]) {
            [weakSelf.delegate addressbookHeaderWithOutside:weakSelf];
        }
    }];
    [self.friendsView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addressbookHeaderWithFriends:)]) {
            [weakSelf.delegate addressbookHeaderWithFriends:weakSelf];
        }
    }];
    [self.applyView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addressbookHeaderWithApply:)]) {
            [weakSelf.delegate addressbookHeaderWithApply:weakSelf];
        }
    }];
    [self.groupView setTapActionWithBlock:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(addressbookHeaderWithGroup:)]) {
            [weakSelf.delegate addressbookHeaderWithGroup:weakSelf];
        }
    }];
}

@end
