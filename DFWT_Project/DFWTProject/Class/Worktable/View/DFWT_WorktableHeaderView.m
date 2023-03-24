//
//  DFWT_WorktableHeaderView.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/21.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_WorktableHeaderView.h"
@interface DFWT_WorktableHeaderView()
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@end
@implementation DFWT_WorktableHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cycleView.currentPageDotColor = [UIColor whiteColor];
    self.cycleView.imageURLStringsGroup = @[@"banner",@"banner"];
    self.cycleView.showPageControl = YES;
    self.cycleView.backgroundColor = [UIColor whiteColor];
    self.cycleView.autoScroll = YES;
    self.cycleView.layer.masksToBounds = YES;
    self.cycleView.layer.cornerRadius = 10;
    self.bottomView.layer.masksToBounds = YES;
    self.bottomView.layer.cornerRadius = 10;
    self.leftBtn.layer.masksToBounds = YES;
    self.leftBtn.layer.cornerRadius = 6;
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.layer.cornerRadius = 6;
}
- (IBAction)leftAction:(UIButton *)sender {
    if (self.leftBtnBlock) {
        self.leftBtnBlock();
    }
}
- (IBAction)rightAction:(UIButton *)sender {
}

@end
