//
//  DFWT_MineController.m
//  DFWTProject
//
//  Created by Administrator on 2022/8/22.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MineController.h"
#import "IMYAppGrayStyle.h"
@interface DFWT_MineController ()
@property (weak, nonatomic) IBOutlet UIView *contentHView;
@property (weak, nonatomic) IBOutlet UIView *contentVView;
@property (weak, nonatomic) IBOutlet UIView *settingView;
@property (nonatomic,assign)BOOL isGray;
@end

@implementation DFWT_MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)setUI{
    self.contentHView.shadowOpacity(1).shadowColor(DEF_RGBAColor(0, 0, 0, 0.06)).shadowRadius(40).shadowOffset(CGSizeMake(0, 2)).conrnerRadius(20).showVisual();
    self.contentVView.shadowOpacity(1).shadowColor(DEF_RGBAColor(0, 0, 0, 0.06)).shadowRadius(40).shadowOffset(CGSizeMake(0, 2)).conrnerRadius(20).showVisual();
    self.isGray = NO;
    DEF_WeakSelf(self)
    [self.settingView setTapActionWithBlock:^{
        weakSelf.isGray = !weakSelf.isGray;
        if (weakSelf.isGray) {
            [IMYAppGrayStyle open];
        }else{
            [IMYAppGrayStyle close];
        }
       
    }];
}

@end
