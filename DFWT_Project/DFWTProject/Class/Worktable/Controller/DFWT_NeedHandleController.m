//
//  DFWT_NeedHandleController.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/24.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_NeedHandleController.h"
#import "CustomSegmentView.h"

@interface DFWT_NeedHandleController ()
@property (nonatomic,strong)CustomSegmentView *segment;

@end

@implementation DFWT_NeedHandleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
}

- (void)setUI{
    self.navigationItem.title = @"待办";
    [self.view addSubview:self.segment];
}

//布局
-(void)setLayout{
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.left.right.equalTo(self.view);
    }];
}

//懒加载
- (CustomSegmentView *)segment{
    if (!_segment) {
        _segment = [[CustomSegmentView alloc]initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, 50) titles:@[@"进行中",@"已逾期",@"已完成"]];
        _segment.backgroundColor = [UIColor whiteColor];
        _segment.segmentNormalColor = DEF_HEXColor(0x4E4F58);
        _segment.segmentTintColor = [UIColor blackColor];
        _segment.indicateColor = DEF_APPCOLOR;
    }
    return _segment;
}
@end
