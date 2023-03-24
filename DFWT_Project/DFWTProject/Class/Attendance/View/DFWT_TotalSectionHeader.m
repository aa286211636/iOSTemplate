//
//  DFWT_TotalSectionHeader.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/2.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_TotalSectionHeader.h"
@interface DFWT_TotalSectionHeader()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *countLb;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;

@end
@implementation DFWT_TotalSectionHeader

-(void)awakeFromNib{
    [super awakeFromNib];
    DEF_WeakSelf(self)
    [self setTapActionWithBlock:^{
        if (weakSelf.headerBlock) {
            weakSelf.headerBlock();
        }
    }];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = title;
}

-(void)setCount:(NSString *)count{
    _count = count;
    self.countLb.text = count;
}

@end
