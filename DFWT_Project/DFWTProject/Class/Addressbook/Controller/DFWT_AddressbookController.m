//
//  DFWT_AddressbookController.m
//  DFWTProject
//
//  Created by Administrator on 2022/8/22.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_AddressbookController.h"
#import "DFWT_SearchView.h"
#import "DFWT_AddressbookCell.h"
#import "BMChineseSort.h"
#import "DFWT_AddressbookHeader.h"
#import "DFWT_AdressbookSectionHeader.h"
#import "DFWT_MyGroupController.h"
#import "DFWT_OutsideContactsController.h"
@interface DFWT_AddressbookController ()<UITableViewDelegate,UITableViewDataSource,DFWT_AddressbookHeaderDelegate>
@property (nonatomic,strong)UIView *searchContainer;//搜索容器
@property (nonatomic,strong)DFWT_SearchView *searchView;//搜索视图
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)DFWT_AddressbookHeader *header;
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *firstLetterArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray<NSMutableArray *> *sortedModelArr;

@end

@implementation DFWT_AddressbookController{
    NSArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
    [self setData];
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

- (void)setUI{
    //搜索视图
    self.searchContainer = [[UIView alloc]init];
    self.searchContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchContainer];
    
    self.searchView = DEF_GetNib(@"DFWT_SearchView");
    [self.searchContainer addSubview:self.searchView];

    //左侧
    UILabel *left = [UILabel new];
    left.text = @"通讯录";
    left.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    //右侧
    UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"addressbook_nav_add"] style:UIBarButtonItemStylePlain target:self action:nil];;
    self.navigationItem.rightBarButtonItem = Item;
    
    UIView *headerContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 455)];
    self.header = DEF_GetNib(@"DFWT_AddressbookHeader");
    self.header.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 455);
    self.header.delegate = self;
    [headerContainer addSubview:self.header];
    self.table.tableHeaderView = headerContainer;
    [self.view addSubview:self.table];

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
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.searchContainer.mas_bottom);
    }];
}
//DFWT_AddressbookHeaderDelegate
- (void)addressbookHeaderWithOrganization:(DFWT_AddressbookHeader *)header{
    
}
-(void)addressbookHeaderWithUserAccess:(DFWT_AddressbookHeader *)header{
    
}
- (void)addressbookHeaderWithFriends:(DFWT_AddressbookHeader *)header{
    
}

- (void)addressbookHeaderWithApply:(DFWT_AddressbookHeader *)header{
    
}

- (void)addressbookHeaderWithGroup:(DFWT_AddressbookHeader *)header{
    DFWT_MyGroupController *vc = [[DFWT_MyGroupController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)addressbookHeaderWithOutside:(DFWT_AddressbookHeader *)header{
    DFWT_OutsideContactsController *vc = [[DFWT_OutsideContactsController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
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
