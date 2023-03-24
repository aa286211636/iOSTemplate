//
//  DFWT_DocumentController.m
//  DFWTProject
//
//  Created by Administrator on 2022/8/22.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_DocumentController.h"
#import "DFWT_SearchView.h"
#import "CustomSegmentView.h"
#import "DFWT_DocumentHeadView.h"
#import "DFWT_CompanyZoneView.h"
#import "DFWT_LatelyZoneView.h"
#import "DFWT_PrivateZoneView.h"
@interface DFWT_DocumentController ()
@property (nonatomic,strong)UIView *searchContainer;//搜索容器
@property (nonatomic,strong)DFWT_SearchView *searchView;//搜索视图
@property (nonatomic,strong)CustomSegmentView *segment;
@property (nonatomic,strong)DFWT_DocumentHeadView *headView;
@property (nonatomic,strong)DFWT_CompanyZoneView *companyZoneView;
@property (nonatomic,strong)DFWT_LatelyZoneView *latelyZoneView;
@property (nonatomic,strong)DFWT_PrivateZoneView *privateZoneView;
@end

@implementation DFWT_DocumentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
}

- (void)setUI{
    self.view.backgroundColor = DEF_TABLEBGCOLOR;
    //左侧
    UILabel *left = [UILabel new];
    left.text = @"云盘与文档";
    left.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    //右侧
    UIBarButtonItem *Item1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"doc_nav_1"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *Item2 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"doc_nav_2"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *empty = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[Item1,Item2,empty];
    //搜索视图
    self.searchContainer = [[UIView alloc]init];
    self.searchContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchContainer];
    
    self.searchView = DEF_GetNib(@"DFWT_SearchView");
    [self.searchContainer addSubview:self.searchView];
    [self.view addSubview:self.segment];
    DEF_WeakSelf(self)
    [self.segment selectedAtIndex:^(NSUInteger index, UIButton * _Nonnull button) {
        DEF_StrongSelf(weakSelf)
        if (!index) {
            strongSelf.companyZoneView.hidden = NO;
            strongSelf.latelyZoneView.hidden = YES;
            strongSelf.privateZoneView.hidden = YES;
        }else if (index == 1) {
            strongSelf.companyZoneView.hidden = YES;
            strongSelf.latelyZoneView.hidden = YES;
            strongSelf.privateZoneView.hidden = NO;
        }else{
            strongSelf.companyZoneView.hidden = YES;
            strongSelf.latelyZoneView.hidden = NO;
            strongSelf.privateZoneView.hidden = YES;
        }
    }];
    self.headView = DEF_GetNib(@"DFWT_DocumentHeadView");
    [self.view addSubview:self.headView];
    
    self.companyZoneView = [[DFWT_CompanyZoneView alloc]init];
    self.companyZoneView.dataArr = @[@"共同空间",@"云盘",@"群文件"];
    [self.view addSubview:self.companyZoneView];
    self.latelyZoneView = [[DFWT_LatelyZoneView alloc]init];
    [self.view addSubview:self.latelyZoneView];
    self.privateZoneView = [[DFWT_PrivateZoneView alloc]init];
    self.privateZoneView.dataArr = @[];
    [self.view addSubview:self.privateZoneView];
    self.companyZoneView.hidden = NO;
    self.latelyZoneView.hidden = YES;
    self.privateZoneView.hidden = YES;
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
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).offset(10);
        make.height.mas_equalTo(105);
        make.left.right.equalTo(self.view);
    }];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(10);
        make.height.mas_equalTo(50);
        make.left.right.equalTo(self.view);
    }];
    [self.companyZoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segment.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.privateZoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segment.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.latelyZoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segment.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

//懒加载
- (CustomSegmentView *)segment{
    if (!_segment) {
        _segment = [[CustomSegmentView alloc]initWithFrame:CGRectMake(0,0, DEF_SCREEN_WIDTH * 0.7, 50) titles:@[@"企业盘",@"私人盘",@"最近"]];
        _segment.backgroundColor = [UIColor whiteColor];
        _segment.segmentNormalColor = DEF_HEXColor(0x4E4F58);
        _segment.segmentTintColor = [UIColor blackColor];
        _segment.indicateColor = DEF_APPCOLOR;
    }
    return _segment;
}
@end
