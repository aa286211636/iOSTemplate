//
//  DFWT_HREmployeeController.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/2.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_HREmployeeController.h"
#import "DFWT_HREmployeeInfoController.h"
#import "DFWT_EmployeeCell.h"
#import "DFWT_EmployeeModel.h"

@interface DFWT_HREmployeeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) MJRefreshAutoNormalFooter *footer;
@property (nonatomic,assign) NSInteger page;//当前页码
@property (nonatomic,assign) NSInteger pageTotal;//总页码
@property (nonatomic,assign) NSInteger pageSize;//每页数量
@property (nonatomic,assign) BOOL isRefresh;//是否是刷新状态
@property (nonatomic,strong)NSMutableArray <DFWT_EmployeeInfoModel *>*dataArrM;//数据源
@end

@implementation DFWT_HREmployeeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
    [self requestList];
}
//初始化
- (void)setUI{
    self.page = 1;
    self.pageTotal = 1;
    self.isRefresh = NO;
    self.pageSize = 10;
    self.dataArrM = [NSMutableArray array];
    self.view.backgroundColor = DEF_TABLEBGCOLOR;
    self.navigationItem.title = @"员工管理";
    [self.view addSubview:self.table];
    //设置刷新
    DEF_WeakSelf(self)
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DEF_StrongSelf(weakSelf)
        //进行数据刷新操作
        strongSelf.page = 1;
        strongSelf.isRefresh = YES;
        [strongSelf requestList];
        [strongSelf.table.mj_header endRefreshing];
        [strongSelf.table.mj_footer resetNoMoreData];
    }];
    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        DEF_StrongSelf(weakSelf)
        //进行数据刷新操作
        strongSelf.isRefresh = NO;
        strongSelf.page++;
        if (strongSelf.page <= strongSelf.pageTotal) {
            [strongSelf requestList];
            [strongSelf.table.mj_header endRefreshing];
            [strongSelf.table.mj_footer endRefreshing];
        }else{
            [strongSelf.table.mj_header endRefreshing];
            [strongSelf.table.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    self.footer.stateLabel.hidden = YES;
    self.table.mj_footer = self.footer;
}

//布局
-(void)setLayout{
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-DEF_SafeBotoomH);
    }];
}

-(void)requestList{
    DEF_WeakSelf(self)
    [self showHUD];
    [DFWT_EmployeeModel fetchDataConfigure:^(NSDictionary *__autoreleasing *arguments, NSString *__autoreleasing *requestUrl, ApiRequestMethod *requestMethod, BOOL *MD5Encryption, NSDictionary *__autoreleasing *HTTPHeaders) {
        *HTTPHeaders = @{@"Content-Type":@"application/json"};
        *arguments = @{
            @"pageNum":@(weakSelf.page),
            @"pageSize":@(weakSelf.pageSize),
        };
        *requestUrl = [NSString stringWithFormat:@"%@%@",BASEURL_Login,API_BasicInformation_List];
        *requestMethod  = ApiRequestMethodPOSTBody;
        *MD5Encryption = NO;
    } complate:^(BOOL finished, NSDictionary *jsonObject, id resultModel, NSError *error) {
        DEF_StrongSelf(weakSelf)
        [strongSelf hideHUD];
        if (error) {
            [strongSelf showHUDMessage:@"服务器连接失败"];
            return ;
        }
        DFWT_EmployeeModel *model = resultModel;
        if (model.code  == 0) {
            NSInteger pageTotal = model.total/weakSelf.pageSize;
            NSInteger left = model.total%weakSelf.pageSize;
            if (left > 0) {
                pageTotal += 1;
            }
            strongSelf.pageTotal = pageTotal;
            if (strongSelf.isRefresh || (strongSelf.pageTotal == strongSelf.page && strongSelf.isRefresh)) {
                strongSelf.dataArrM  = [NSMutableArray arrayWithArray:model.data];
            }else{
                [strongSelf.dataArrM addObjectsFromArray:model.data];
            }
        }else{
            [strongSelf showHUDMessage:model.msg];
        }
        [strongSelf.table reloadData];
    }];
}

- (void)requestDel:(NSString *)ID indexPath:(NSIndexPath *)indexPath{
    DEF_WeakSelf(self)
    [self showHUD];
    [BaseRequestModel fetchDataConfigure:^(NSDictionary *__autoreleasing *arguments, NSString *__autoreleasing *requestUrl, ApiRequestMethod *requestMethod, BOOL *MD5Encryption, NSDictionary *__autoreleasing *HTTPHeaders) {
        *HTTPHeaders = @{@"Content-Type":@"application/json;charset=UTF-8"};
        *arguments = @{@"id":ID};
        *requestUrl = [NSString stringWithFormat:@"%@%@",BASEURL_Login,API_BasicInformation_Del];
        *requestMethod  = ApiRequestMethodPOSTBody;
        *MD5Encryption = NO;
    } complate:^(BOOL finished, NSDictionary *jsonObject, id resultModel, NSError *error) {
        DEF_StrongSelf(weakSelf)
        [strongSelf hideHUD];
        if (error) {
            [strongSelf showHUDMessage:@"服务器连接失败"];
            return ;
        }
        BaseRequestModel *model = resultModel;
        if (model.code  == 0) {
            [strongSelf.dataArrM removeObjectAtIndex:indexPath.row];
            [strongSelf.table reloadData];
        }else{
            [strongSelf showHUDMessage:model.msg];
        }
        [strongSelf.table reloadData];
    }];
}

//UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DFWT_EmployeeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFWT_EmployeeCell"];
    DFWT_EmployeeInfoModel *model = self.dataArrM[indexPath.row];
    cell.model = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DFWT_EmployeeInfoModel *model = self.dataArrM[indexPath.row];
    DFWT_HREmployeeInfoController *vc = [[DFWT_HREmployeeInfoController alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    DFWT_EmployeeInfoModel *model = self.dataArrM[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DEF_WeakSelf(self)
        [LEEAlert alert].config
        .LeeTitle(@"提示")
        .LeeContent(@"确定删除吗？")
        .LeeClickBackgroundClose(YES)
        .LeeAddAction(^(LEEAction * _Nonnull action) {
            action.title = @"确定";
            action.clickBlock = ^{
                //删除数据源
                [weakSelf requestDel:model.ID indexPath:indexPath];
             };
        })
        .LeeAddAction(^(LEEAction * _Nonnull action) {
            action.title = @"取消";
        })
        .LeeShow();
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 删除
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//懒加载控件
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
        [_table registerNib:[UINib nibWithNibName:@"DFWT_EmployeeCell" bundle:nil] forCellReuseIdentifier:@"DFWT_EmployeeCell"];
    }
    return _table;
}

@end
