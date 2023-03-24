//
//  DFWT_MeetHomeController.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/28.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MeetHomeController.h"
#import "DFWT_TabController.h"
#import "DFWT_MeetHomeHeader.h"
#import "WMDragView.h"
#import "DFWT_MeetHistoryCell.h"
#import "DFWT_MeetActionsheet.h"
#import "DFWT_MeetOrderController.h"
@interface DFWT_MeetHomeController ()<UITableViewDelegate,UITableViewDataSource,DFWT_MeetHomeHeaderDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) DFWT_MeetHomeHeader *header;
@property (nonatomic,strong) WMDragView *dragView;
@property (nonatomic,strong) DFWT_MeetActionsheet *actionsheet;

@end

@implementation DFWT_MeetHomeController{
    NSArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.dragView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(18, 18)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.dragView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.dragView.layer.mask = maskLayer;
}

- (void)setUI{
    self.navigationItem.title = @"中油易连";
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 54, 30);
    [back setImage:[UIImage imageNamed:@"meet_nav_back"] forState:UIControlStateNormal];
    [back setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"meet_nav"] style:UIBarButtonItemStylePlain target:self action:nil];;
    self.navigationItem.rightBarButtonItem = Item;
    
    self.header = DEF_GetNib(@"DFWT_MeetHomeHeader");
    self.header.delegate = self;
    [self.view addSubview:self.header];
    [self.view addSubview:self.dragView];
    [self.view addSubview:self.table];
    
    self.dragView.clickDragViewBlock = ^(WMDragView *dragView) {

    };
    
    _dataArr = @[@"王月发起的视频会议",@"王月发起的语音会议",@"王月发起的普通电话",@"陈阳发起的视频会议",@"王月发起的语音会议",@"王月发起的普通电话"];
}

-(void)setLayout{
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(5);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(190);
    }];
    [self.dragView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-100);
        make.right.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(36);
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.header.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)back:(UIButton *)sender{
    DFWT_TabController *tab = [[DFWT_TabController alloc]init];
    tab.selectedIndex = 2;
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}
//UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc]init];
    header.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *lb = [[UILabel alloc]init];
    lb.backgroundColor = [UIColor whiteColor];
    lb.frame = CGRectMake(20, 0, DEF_SCREEN_WIDTH - 20, 40);
    lb.font = [UIFont boldSystemFontOfSize:18];
    lb.text = @"历史会议";
    [header addSubview:lb];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DFWT_MeetHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFWT_MeetHistoryCell"];
    cell.type = indexPath.row;
    cell.count = @"3人";
    cell.time = @"08月23日 12：40-12：42";
    cell.title = _dataArr[indexPath.row];
    return cell;
}

//DFWT_MeetHomeHeaderDelegate
- (void)DFWT_MeetHomeHeaderJoinMeeting:(DFWT_MeetHomeHeader *)header{};
- (void)DFWT_MeetHomeHeaderOrderMeeting:(DFWT_MeetHomeHeader *)header{
    DFWT_MeetOrderController *vc = [[DFWT_MeetOrderController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
};
- (void)DFWT_MeetHomeHeaderShareDesktop:(DFWT_MeetHomeHeader *)header{};
- (void)DFWT_MeetHomeHeaderStartMeeting:(DFWT_MeetHomeHeader *)header{
    [self showActionSheet];
};

- (void)showActionSheet{
    DEF_WeakSelf(self)
    [LEEAlert actionsheet].config
    .LeeAddTitle(^(UILabel * _Nonnull label) {
        label.text = @"发起会议";
        label.font = [UIFont systemFontOfSize:15];
     })
    .LeeMaxWidth(DEF_SCREEN_WIDTH)
    .LeeAddCustomView(^(LEECustomView * _Nonnull custom) {
        weakSelf.actionsheet = DEF_GetNib(@"DFWT_MeetActionsheet");
        weakSelf.actionsheet.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 180);
        custom.view = weakSelf.actionsheet;
    })
    .LeeCancelAction(@"取消", ^{
    })
    .LeeShow();
}
//懒加载控件
- (UITableView *)table{
if (!_table) {
    _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    _table.estimatedRowHeight = 0;
    _table.estimatedSectionHeaderHeight = 0;
    _table.estimatedSectionFooterHeight = 0;
    _table.tableFooterView = [UIView new];
    [_table registerNib:[UINib nibWithNibName:@"DFWT_MeetHistoryCell" bundle:nil] forCellReuseIdentifier:@"DFWT_MeetHistoryCell"];

}
return _table;
}

-(WMDragView *)dragView{
if (!_dragView) {
    _dragView = [[WMDragView alloc] init];
    _dragView.isKeepBounds = YES;
    _dragView.dragEnable = YES;
    _dragView.layer.masksToBounds = YES;
    _dragView.backgroundColor = DEF_HEXColor(0xD7E8FF);
    _dragView.button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _dragView.button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_dragView.button setTitleColor:DEF_HEXColor(0x1079FF) forState:UIControlStateNormal];
    [_dragView.button setTitle:@"历史会议 >" forState:UIControlStateNormal];
 
}
return  _dragView;
}

@end
