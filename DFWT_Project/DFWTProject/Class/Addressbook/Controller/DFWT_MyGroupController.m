//
//  DFWT_MyGroupController.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/26.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MyGroupController.h"
#import "CustomSegmentView.h"

@interface DFWT_MyGroupController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)CustomSegmentView *segment;
@property(nonatomic,strong)UITableView *table;

@end

@implementation DFWT_MyGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
}

- (void)setUI{
    
    [self.view addSubview:self.segment];
    [self.view addSubview:self.table];
    self.navigationItem.title = @"我的群组";
    //右侧
    UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"group_nav_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = Item;
}

//布局
-(void)setLayout{
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-DEF_SafeBotoomH);
        make.top.equalTo(self.segment.mas_bottom);
    }];
}

- (void)addAction:(UIBarButtonItem *)item{
    
}

// UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"新的好友";
    cell.imageView.image = [UIImage imageNamed:@"group_icon"];
    return cell;
}

//懒加载
- (CustomSegmentView *)segment{
    if (!_segment) {
        _segment = [[CustomSegmentView alloc]initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH, 50) titles:@[@"我管理的群组",@"我加入的群组"]];
        _segment.backgroundColor = [UIColor whiteColor];
        _segment.segmentNormalColor = DEF_HEXColor(0x4E4F58);
        _segment.segmentTintColor = [UIColor blackColor];
        _segment.indicateColor = DEF_APPCOLOR;
    }
    return _segment;
}

//懒加载
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.showsVerticalScrollIndicator = NO;
        _table.delegate = self;
        _table.dataSource = self;
        _table.estimatedRowHeight = 0;
        _table.estimatedSectionHeaderHeight = 0;
        _table.estimatedSectionFooterHeight = 0;
        _table.tableFooterView = [UIView new];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _table;
}

@end
