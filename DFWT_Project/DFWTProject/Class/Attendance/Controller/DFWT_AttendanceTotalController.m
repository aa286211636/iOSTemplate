//
//  DFWT_AttendanceTotalController.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/2.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_AttendanceTotalController.h"
#import "DFWT_TabController.h"
#import "DFWT_CalendarController.h"
#import "DFWT_AttendanceHeader.h"
#import "DFWT_TotalSectionHeader.h"

@interface DFWT_AttendanceTotalController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) DFWT_AttendanceHeader *header;
@property (nonatomic, strong) NSMutableArray *dataArrM;
@end

@implementation DFWT_AttendanceTotalController{
    NSArray *_sectionArr;
}
- (NSMutableArray *)dataArrM {
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
        //初始化数据源 初始化3分组数据
        for (int i = 0; i < _sectionArr.count; i++) {
            NSMutableArray *subArr = [NSMutableArray array];
            [_dataArrM addObject:subArr];
        }
    }
    return _dataArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setData];
    [self setUI];
    [self setLayout];
}

- (void)setUI{
    self.navigationItem.title = @"统计";
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 54, 30);
    [back setImage:[UIImage imageNamed:@"meet_nav_back"] forState:UIControlStateNormal];
    [back setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    //右侧
    UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithTitle:@"打卡月历" style:UIBarButtonItemStylePlain target:self action:@selector(navigationAction)];;
    self.navigationItem.rightBarButtonItem = Item;
    
    UIView *headerContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 85)];
    self.header = DEF_GetNib(@"DFWT_AttendanceHeader");
    self.header.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 85);
    self.header.constraint.constant = 0;
    [headerContainer addSubview:self.header];
    self.table.tableHeaderView = headerContainer;
    [self.view addSubview:self.table];
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
- (void)setData{
    _sectionArr = @[@"出勤天数",@"出勤班次",@"休息天数",@"迟到",@"早退",@"缺卡",@"未打卡",@"外勤"];
}

- (void)navigationAction{
    DFWT_CalendarController *vc = [[DFWT_CalendarController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}

//UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArrM.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *subArr = self.dataArrM[section];
    return subArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DFWT_TotalSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DFWT_TotalSectionHeader"];
    if (!header) {
        header = [[DFWT_TotalSectionHeader alloc]init];
    }
    header.title = _sectionArr[section];
    header.count = @"共3天";
    DEF_WeakSelf(self)
    header.headerBlock = ^() {
        NSMutableArray *subArr = weakSelf.dataArrM[section];
        if (subArr.count > 0) {
            [subArr removeAllObjects];
        }else{
            NSInteger random = 1 +  (arc4random() % 3);
            for (int i = 0;i < random; i++){
                [subArr addObject:@""];
            }
        }
        [tableView beginUpdates];
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndex:section];
        [tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    };
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"2022-09-22(星期一)";
    cell.detailTextLabel.text = @"1天";
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = DEF_HEXColor(0xf9f9f9);
}

//懒加载控件
- (UITableView *)table{
if (!_table) {
    _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = [UIColor whiteColor];
    _table.delegate = self;
    _table.dataSource = self;
    _table.estimatedRowHeight = 0;
    _table.estimatedSectionHeaderHeight = 0;
    _table.estimatedSectionFooterHeight = 0;
    _table.tableFooterView = [UIView new]; 
    [_table registerNib:[UINib nibWithNibName:@"DFWT_TotalSectionHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"DFWT_TotalSectionHeader"];
}
return _table;
}

@end
