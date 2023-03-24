//
//  DFWT_OutsideContactsController.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/26.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_OutsideContactsController.h"
#import "DFWT_AddOutContactsController.h"
#import "DFWT_AddressbookCell.h"
#import "DFWT_AdressbookSectionHeader.h"
#import "DFWT_OutsideHeaderView.h"
#import "BMChineseSort.h"

@interface DFWT_OutsideContactsController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  UITableView *table;
@property (nonatomic,strong)  DFWT_OutsideHeaderView *header;
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *firstLetterArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray<NSMutableArray *> *sortedModelArr;

@end

@implementation DFWT_OutsideContactsController{
    NSArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setData];
    [self setLayout];
}

- (void)setUI{
    self.view.backgroundColor = DEF_TABLEBGCOLOR;
    self.navigationItem.title = @"外部联系人";
    UIView *headerContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 70)];
    self.header = DEF_GetNib(@"DFWT_OutsideHeaderView");
    self.header.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 70);
    DEF_WeakSelf(self)
    self.header.addContactcBlock = ^{
        DFWT_AddOutContactsController *vc = [[DFWT_AddOutContactsController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:NO];

    };
    [headerContainer addSubview:self.header];
    self.table.tableHeaderView = headerContainer;
    [self.view addSubview:self.table];
}

- (void)setData{
    self.firstLetterArray = [NSMutableArray array];
    self.sortedModelArr = [NSMutableArray array];
    _dataArr = @[@"樊苗苗",@"苏大有",@"小袁袁"];
    DEF_WeakSelf(self)
    //排序 Person对象
    [BMChineseSort sortAndGroup:_dataArr key:nil finish:^(bool isSuccess, NSMutableArray *unGroupedArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        DEF_StrongSelf(weakSelf);
        if (isSuccess) {
            strongSelf.firstLetterArray = sectionTitleArr;
            strongSelf.sortedModelArr = sortedObjArr;
            [strongSelf.table reloadData];
        }
    }];
}

-(void)setLayout{
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
    }];
}

//UITableViewDelegate

//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.firstLetterArray count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sortedModelArr[section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.firstLetterArray;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DFWT_AdressbookSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"DFWT_AdressbookSectionHeader"];
    header.textLb.text = [self.firstLetterArray objectAtIndex:section];
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DFWT_AddressbookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFWT_AddressbookCell" forIndexPath:indexPath];
    cell.text = self.sortedModelArr[indexPath.section][indexPath.row];
    cell.imgStr = self.sortedModelArr[indexPath.section][indexPath.row];
    return cell;
}

//懒加载
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
        //更改索引颜色
        _table.sectionIndexBackgroundColor = [UIColor clearColor];
        _table.sectionIndexColor = DEF_HEXColor(0x111111);
        [_table registerNib:[UINib nibWithNibName:@"DFWT_AddressbookCell" bundle:nil] forCellReuseIdentifier:@"DFWT_AddressbookCell"];
        [_table registerNib:[UINib nibWithNibName:@"DFWT_AdressbookSectionHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"DFWT_AdressbookSectionHeader"];
    }
    return _table;
}
@end
