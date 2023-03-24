//
//  DFWT_CompanyZoneView.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/7.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_CompanyZoneView.h"
@interface DFWT_CompanyZoneView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@end

@implementation DFWT_CompanyZoneView

-(instancetype)init{
    if (self = [super init]) {
        [self setUI];
        [self setLayout];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        [self setLayout];
    }
    return self;
}

- (void)setUI{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 40)];
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, DEF_SCREEN_WIDTH - 20, 40)];
    lb.font = [UIFont systemFontOfSize:18];
    lb.text = @"西安麦特赛尔软件技术有限公司";
    [header addSubview:lb];
    self.table.tableHeaderView = header;
    [self addSubview:self.table];
    
}

-(void)setLayout{
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [self.table reloadData];
}

//UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.detailTextLabel.text = @"5413MB";
    cell.detailTextLabel.textColor = DEF_HEXColor(0x87898E);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.imageView.image = [UIImage imageNamed:@"doc_file"];
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
        [_table registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    }
    return _table;
}


@end
