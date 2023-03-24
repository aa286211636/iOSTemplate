//
//  DFWT_MessageController.m
//  DFWTProject
//
//  Created by Administrator on 2022/8/22.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MessageController.h"
#import "DFWT_SearchView.h"
#import "DFWT_MsgSegmentView.h"
#import "DFWT_MsgCell.h"
@interface DFWT_MessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *searchContainer;//搜索容器
@property (nonatomic,strong)DFWT_SearchView *searchView;//搜索视图
@property (nonatomic,strong)DFWT_MsgSegmentView *segmentView;//搜索视图
@property(nonatomic,strong)UITableView *table;

@end

@implementation DFWT_MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
}

- (void)setUI{
    //搜索视图
    self.searchContainer = [[UIView alloc]init];
    self.searchContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchContainer];
    
    self.searchView = DEF_GetNib(@"DFWT_SearchView");
    [self.searchContainer addSubview:self.searchView];
    
    self.segmentView = DEF_GetNib(@"DFWT_MsgSegmentView");
    [self.view addSubview:self.segmentView];
    
    [self.view addSubview:self.table];
    //左侧
    UILabel *left = [UILabel new];
    left.text = @"消息";
    left.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    //右侧
    UIBarButtonItem *Item1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"msg_nav_1"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *Item2 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"msg_nav_2"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *empty = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[Item1,Item2,empty];
}

//布局
-(void)setLayout{
    [self.searchContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchContainer).offset(10);
        make.bottom.equalTo(self.searchContainer).offset(-10);
        make.left.equalTo(self.searchContainer).offset(20);
        make.right.equalTo(self.searchContainer).offset(-20);
    }];
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchContainer.mas_bottom);
        make.height.mas_equalTo(50);
        make.left.equalTo(self.searchContainer).offset(20);
        make.right.equalTo(self.searchContainer).offset(-20);
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.segmentView.mas_bottom);
    }];
}

//UITableViewDelegate

//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DFWT_MsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFWT_MsgCell"];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}
//懒加载
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.showsVerticalScrollIndicator = NO;
        _table.backgroundColor = DEF_TABLEBGCOLOR;
        _table.delegate = self;
        _table.dataSource = self;
        _table.estimatedRowHeight = 0;
        _table.estimatedSectionHeaderHeight = 0;
        _table.estimatedSectionFooterHeight = 0;
        _table.tableFooterView = [UIView new];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerNib:[UINib nibWithNibName:@"DFWT_MsgCell" bundle:nil] forCellReuseIdentifier:@"DFWT_MsgCell"];
    }
    return _table;
}

@end
