//
//  DFWT_WorktableController.m
//  DFWTProject
//
//  Created by Administrator on 2022/8/22.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_WorktableController.h"
#import "DFWT_NeedHandleController.h"
#import "DFWT_MeetingTabController.h"
#import "DFWT_HREmployeeController.h"
#import "DFWT_AttendanceTabController.h"
#import "DFWT_CollectionCell.h"
#import "JJCollectionViewRoundFlowLayout.h"
#import "DFWT_WorktableReusableView.h"
#import "DFWT_WorktableReusableViewFooter.h"
#import "DFWT_WorktableHeaderView.h"

@interface DFWT_WorktableController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,JJCollectionViewDelegateRoundFlowLayout>
@property (nonatomic,strong) UICollectionView *collection;
@end

@implementation DFWT_WorktableController{
    NSArray *_workImgArr;
    NSArray *_workTextArr;
    NSArray *_workTitleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
}

- (void)setUI {
    self.view.backgroundColor = DEF_TABLEBGCOLOR;
    [self.view addSubview:self.collection];
    [self setNav];
    _workTitleArr = @[@"",@"常用功能",@"安全复工",@"日常工作",@"人事管理",@"财务管理",@"行政管理",@"市场营销",@"市场营销",@"协同效率",@"智能人事",@"其他应用"];
    _workTextArr = @[@[],
    @[@"我要查询",@"我要申请",@"我要提问",@"我要学习"],
    @[@"云端办公室",@"视频会议",@"每日填报",@"铁人先锋",@"智能办公",@"考勤打卡",@"统一代办"],
    @[@"考勤打卡",@"签到",@"审批",@"周报"],
    @[@"招聘",@"离职申请单",@"调岗申请单",@"加班",@"出差",@"外出",@"请假",@"补卡申请",@"审批"],
    @[@"付款申请",@"收款申请",@"暂支申请"],
    @[@"名片印刷申请",@"物品申领",@"盖章申请",@"采购申请",@"公告",@"智能会议室",@"资质使用申请",@"用车申请",@"固定资产申请"],
    @[@"找商机",@"日志",@"工作总结",@"销售合同审批",@"周报",@"日报",@"月报",@"拜访记录",@"销售合同盖章审批"],
    @[@"客户管理",@"添加外部联系人",@"扫名片",@"客户经理日报",@"投票助手",@"活动报名"],
    @[@"云盘",@"即时通讯",@"电话会议",@"办公电话",@"视频会议"],
    @[@"员工健康"],
    @[@"运动",@"智能会务",@"智能填表",@"智能云打印"]
    ];

    _workImgArr = @[@[],
    @[@"work_1_1",@"work_1_2",@"work_1_3",@"work_1_4"],
    @[@"work_2_1",@"work_2_2",@"work_2_3",@"work_2_4",@"work_2_5",@"work_2_6",@"work_2_7"],
    @[@"work_3_1",@"work_3_2",@"work_3_3",@"work_3_4"],
    @[@"work_4_1",@"work_4_2",@"work_4_3",@"work_4_4",@"work_4_5",@"work_4_6",@"work_4_7",@"work_4_8",@"work_4_9"],
    @[@"work_5_1",@"work_5_2",@"work_5_3"],
    @[@"work_6_1",@"work_6_2",@"work_6_3",@"work_6_4",@"work_6_5",@"work_6_6",@"work_6_7",@"work_6_8",@"work_6_9"],
    @[@"work_7_1",@"work_7_2",@"work_7_3",@"work_7_4",@"work_7_5",@"work_7_6",@"work_7_7",@"work_7_8",@"work_7_9"],
    @[@"work_8_1",@"work_8_2",@"work_8_3",@"work_8_4",@"work_8_5",@"work_8_6"],
    @[@"work_9_1",@"work_9_2",@"work_9_3",@"work_9_4",@"work_9_5"],
    @[@"work_10_1"],
    @[@"work_11_1",@"work_11_2",@"work_11_3",@"work_11_4"]
    ];
}


-(void)setLayout{
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.right.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view);
    }];
}

- (void)setNav {
    //左侧
    UILabel *left = [UILabel new];
    left.text = @"鑫元易联";
    left.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    //右侧
    UIBarButtonItem *Item1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"work_nav_1"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *Item2 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"work_nav_2"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *empty = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[Item1,Item2,empty];
}


#pragma mark - 代理方法 Delegate Methods
// 设置分区
 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 return _workTitleArr.count;
}
 
// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 return [_workTextArr[section] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((DEF_SCREEN_WIDTH - 80)/4, (DEF_SCREEN_WIDTH - 80)/4);
}

 
// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFWT_CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFWT_CollectionCell" forIndexPath:indexPath];
    cell.text = _workTextArr[indexPath.section][indexPath.item];
    cell.imgName = _workImgArr[indexPath.section][indexPath.item];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 0) return  UIEdgeInsetsMake(0, 0, 10, 0);
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 20;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSectionAtIndex:(NSInteger)section{
    return  [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.item == 1) {
        DFWT_MeetingTabController *tab = [[DFWT_MeetingTabController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    }
    if (indexPath.section == 3 && indexPath.item == 0) {
        DFWT_AttendanceTabController *tab = [[DFWT_AttendanceTabController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    }
    if (indexPath.section == 4 && indexPath.item == 0) {
        DFWT_HREmployeeController *vc = [[DFWT_HREmployeeController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
    }
}


#pragma mark - JJCollectionViewDelegateRoundFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout borderEdgeInsertsForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 10, 0);
}

- (JJCollectionViewRoundConfigModel *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout configModelForSectionAtIndex:(NSInteger)section{
    JJCollectionViewRoundConfigModel *model = [[JJCollectionViewRoundConfigModel alloc]init];
    model.backgroundColor = [UIColor whiteColor];
    model.cornerRadius = 10;
    return model;
}


#pragma mark - header&footer

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(DEF_SCREEN_WIDTH - 20, 280);
    }
    return CGSizeMake(DEF_SCREEN_WIDTH - 20, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return CGSizeMake(DEF_SCREEN_WIDTH - 20, 60);
    }
    return CGSizeMake(0, 0);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DEF_WeakSelf(self)
        if (indexPath.section == 0) {
            DFWT_WorktableHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DFWT_WorktableHeaderView" forIndexPath:indexPath];
            header.leftBtnBlock = ^{
                DFWT_NeedHandleController *vc = [[DFWT_NeedHandleController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:NO];
            };
            return header;
        }else{
            DFWT_WorktableReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DFWT_WorktableReusableView" forIndexPath:indexPath];
            header.text = _workTitleArr[indexPath.section];
            if (indexPath.section == 1) {
                header.canExpand = NO;
                header.hasMore = YES;
            }else{
                header.canExpand = YES;
                header.hasMore = NO;
            }
            return header;
        }
    }else{
        DFWT_WorktableReusableViewFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DFWT_WorktableReusableViewFooter" forIndexPath:indexPath];
        return footer;
    }
}

-(UICollectionView *)collection{
    if (!_collection) {
        JJCollectionViewRoundFlowLayout *layout = [[JJCollectionViewRoundFlowLayout alloc]init];
        layout.isCalculateHeader = YES;
        layout.isCalculateTypeOpenIrregularitiesCell = YES;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.dataSource = self;
        _collection.delegate = self;
        _collection.backgroundColor = DEF_TABLEBGCOLOR;
        [_collection registerNib:[UINib nibWithNibName:@"DFWT_CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"DFWT_CollectionCell"];
        [_collection registerNib:[UINib nibWithNibName:@"DFWT_WorktableReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DFWT_WorktableReusableView"];
        [_collection registerNib:[UINib nibWithNibName:@"DFWT_WorktableHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DFWT_WorktableHeaderView"];
        [_collection registerNib:[UINib nibWithNibName:@"DFWT_WorktableReusableViewFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"DFWT_WorktableReusableViewFooter"];
        
    }
    return _collection;
}

@end
