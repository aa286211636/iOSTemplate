//
//  DFWT_AttendanceController.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/1.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_AttendanceController.h"
#import "DFWT_TabController.h"
#import "DFWT_AttendanceSetController.h"
#import "DFWT_AttendanceHeader.h"
#import "DFWT_AttendanceFooter.h"
#import "DFWT_AttendanceCell.h"
@interface DFWT_AttendanceController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) DFWT_AttendanceHeader *header;
@property (nonatomic,strong) DFWT_AttendanceFooter *footer;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation DFWT_AttendanceController

-(void)viewwillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //停止计时器，一旦停止不可重用，需要重新创建
    [self.timer invalidate];
    self.timer = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
    [self timerAction];
}

- (void)setUI{
    self.navigationItem.title = @"考勤打卡";
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 54, 30);
    [back setImage:[UIImage imageNamed:@"meet_nav_back"] forState:UIControlStateNormal];
    [back setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    //右侧
    UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"att_nav_set"] style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];;
    self.navigationItem.rightBarButtonItem = Item;
    
    UIView *headerContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 105)];
    self.header = DEF_GetNib(@"DFWT_AttendanceHeader");
    self.header.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 105);
    [headerContainer addSubview:self.header];
    self.table.tableHeaderView = headerContainer;
    
    UIView *footContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 300)];
    self.footer = DEF_GetNib(@"DFWT_AttendanceFooter");
    self.footer.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 300);
    [footContainer addSubview:self.footer];
    self.table.tableFooterView = footContainer;
    [self.view addSubview:self.table];
}

- (void)setTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    //计时器优先级
    //获取消息当前循环
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop  addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)setAction{
    DFWT_AttendanceSetController *vc = [[DFWT_AttendanceSetController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)timerAction{
    NSDate *date = [NSDate date];
    //创建一个日期格式化对象
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm:ss";//规定格式转化，并转化为当前系统的时间
    NSString *str = [formatter stringFromDate:date];//获取
    self.footer.time = str;
}

-(void)setLayout{
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)back:(UIButton *)sender{
    DFWT_TabController *tab = [[DFWT_TabController alloc]init];
    tab.selectedIndex = 2;
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}

//UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 50;
    }
   return 170;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DFWT_AttendanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFWT_AttendanceCell"];
    if (indexPath.row == 0) {
        cell.isDone = YES;
    }else{
        cell.isDone = NO;
    }
    return cell;
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
    [_table registerNib:[UINib nibWithNibName:@"DFWT_AttendanceCell" bundle:nil] forCellReuseIdentifier:@"DFWT_AttendanceCell"];
}
   return _table;
}

@end
