//
//  DFWT_EmployeeSiBaseListController.m
//  DFWTProject
//
//  Created by Administrator on 2023/3/6.
//  Copyright © 2023 Administrator. All rights reserved.
//

#import "DFWT_EmployeeSiBaseListController.h"
#import "DFWT_EmployeeSi_BaseCell.h"
#import "DFWT_EmployeeSocialModel.h"
@interface DFWT_EmployeeSiBaseListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray <DFWT_EmployeeSocialBaseModel *> *dataArrM;
@property (nonatomic,strong)UITableView *table;


@end

@implementation DFWT_EmployeeSiBaseListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
    [self requestList];
}

- (void)setUI{
    self.navigationItem.title = [NSString stringWithFormat:@"社保基数类型:%@",self.cardinalType];
    [self.view addSubview:self.table];
    DFWT_EmployeeSocialBaseModel *model = [[DFWT_EmployeeSocialBaseModel alloc]init];
    model.SocialInsuranceName = @"缴费名称";
    model.paymentBase = @"缴费基数(元)";
    model.unitPaymentProportion = @"单位缴费比例(%)";
    model.individualPaymentProportion = @"个人缴费比例(%)";
    model.unitPaymentAmount = @"单位缴费金额(元)";
    model.individualPaymentAmount = @"个人缴费金额(元)";
    self.dataArrM = [NSMutableArray arrayWithObject:model];
}

//布局
-(void)setLayout{
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-DEF_SafeBotoomH);
    }];
}

-(void)requestList{
   DEF_WeakSelf(self)
   [self showHUD];
   [DFWT_EmployeeSocialModel fetchDataConfigure:^(NSDictionary *__autoreleasing *arguments, NSString *__autoreleasing *requestUrl, ApiRequestMethod *requestMethod, BOOL *MD5Encryption, NSDictionary *__autoreleasing *HTTPHeaders) {
       *HTTPHeaders = @{@"Content-Type":@"application/json;charset=UTF-8"};
       *arguments = @{@"cardinalType":self.cardinalType.length ? self.cardinalType:@""};
       *requestUrl = [NSString stringWithFormat:@"%@%@",BASEURL_Login,API_BasicInformation_SI_BaseList];
       *requestMethod  = ApiRequestMethodPOSTBody;
       *MD5Encryption = NO;
   } complate:^(BOOL finished, NSDictionary *jsonObject, id resultModel, NSError *error) {
       DEF_StrongSelf(weakSelf)
       [strongSelf hideHUD];
       if (error) {
           [strongSelf showHUDMessage:@"服务器连接失败"];
           return ;
       }
       DFWT_EmployeeSocialModel *model = resultModel;
       if (model.code  == 0) {
           DFWT_EmployeeSocialInfoModel *info = model.data;
           if (info.siBase.count) {
               [strongSelf.dataArrM addObjectsFromArray:info.siBase];
           }
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
    DFWT_EmployeeSi_BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFWT_EmployeeSi_BaseCell"];
    DFWT_EmployeeSocialBaseModel *model = self.dataArrM[indexPath.row];
    cell.model = model;
    if (indexPath.row == self.dataArrM.count-1) {
        cell.hiddenLine = NO;
    }else{
        cell.hiddenLine = YES;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    }
    return 40;
}

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
        [_table registerNib:[UINib nibWithNibName:@"DFWT_EmployeeSi_BaseCell" bundle:nil] forCellReuseIdentifier:@"DFWT_EmployeeSi_BaseCell"];
    }
    return _table;
}
@end
