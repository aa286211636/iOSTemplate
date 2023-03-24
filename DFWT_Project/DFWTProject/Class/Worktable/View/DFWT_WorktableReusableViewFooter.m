//
//  DFWT_WorktableReusableViewFooter.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/20.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_WorktableReusableViewFooter.h"
@interface DFWT_WorktableReusableViewFooter()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation DFWT_WorktableReusableViewFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 10;
}

@end
