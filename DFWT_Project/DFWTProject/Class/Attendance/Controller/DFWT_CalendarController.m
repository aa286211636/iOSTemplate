//
//  DFWT_CalendarController.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/3.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_CalendarController.h"
#import "DFWT_CalendarHeader.h"
#import "DFWT_AttendanceCell.h"
@interface DFWT_CalendarController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) DFWT_CalendarHeader *header;
@end

@implementation DFWT_CalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)setUI{
    self.navigationItem.title = @"考勤月历";
    UIView *headerContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 520)];
    self.header = DEF_GetNib(@"DFWT_CalendarHeader");
    self.header.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 520);
    [headerContainer addSubview:self.header];
    self.table.tableHeaderView = headerContainer;
    [self.view addSubview:self.table];
}

-(void)setLayout{
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(DEF_TabBarH);
    }];
}

//UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   return 150;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DFWT_AttendanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFWT_AttendanceCell"];
    //最后一个cell
    if(indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1){
        cell.isHideLine = YES;
    }else{
        cell.isHideLine = NO;
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
