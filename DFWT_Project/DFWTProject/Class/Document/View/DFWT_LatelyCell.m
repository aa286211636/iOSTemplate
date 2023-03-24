//
//  DFWT_LatelyCell.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/9.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_LatelyCell.h"

@implementation DFWT_LatelyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = DEF_TABLEBGCOLOR.CGColor;
    self.layer.borderWidth = 1;
}

@end
