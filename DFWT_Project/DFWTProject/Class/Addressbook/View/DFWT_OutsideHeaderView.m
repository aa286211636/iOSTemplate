//
//  DFWT_OutsideHeaderView.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/26.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_OutsideHeaderView.h"
@interface DFWT_OutsideHeaderView()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@end
@implementation DFWT_OutsideHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    DEF_WeakSelf(self)
    [self.contentView setTapActionWithBlock:^{
        if (weakSelf.addContactcBlock) {
            weakSelf.addContactcBlock();
        }
    }];
}

@end
