//
//  DFWT_AttendanceApplyController.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/1.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_AttendanceApplyController.h"
#import "DFWT_TabController.h"
#import "DFWT_CollectionCell.h"
@interface DFWT_AttendanceApplyController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collection;

@end

@implementation DFWT_AttendanceApplyController{
    NSArray *_dataArr;
    NSArray *_iconArr;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setData];
    [self setUI];
    [self setLayout];
}

- (void)setUI{
    self.navigationItem.title = @"申请";
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 54, 30);
    [back setImage:[UIImage imageNamed:@"meet_nav_back"] forState:UIControlStateNormal];
    [back setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];

    [self.view addSubview:self.collection];
}

- (void)setData{
    _dataArr = @[@"我发起的",@"我审批的",@"抄送我的",@"补卡申请"];
    _iconArr = @[@"att_faqi",@"att_shenpi",@"att_chaosong",@"att_shenqing"];
}

-(void)setLayout{
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)back:(UIButton *)sender{
    DFWT_TabController *tab = [[DFWT_TabController alloc]init];
    tab.selectedIndex = 2;
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}

#pragma mark - 代理方法 Delegate Methods
// 设置分区
 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 return 1;
}
 
// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 return _dataArr.count;
}
 
// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFWT_CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFWT_CollectionCell" forIndexPath:indexPath];
    cell.text = _dataArr[indexPath.item];
    cell.imgName = _iconArr[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout borderEdgeInsertsForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat W = (DEF_SCREEN_WIDTH - 80)/4;
        CGFloat H = W;
        flowLayout.itemSize = CGSizeMake(W,H);
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(15,15,15,15);//一个section 上左下右间隔
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.dataSource = self;
        _collection.delegate = self;
        [_collection registerNib:[UINib nibWithNibName:@"DFWT_CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"DFWT_CollectionCell"];
    }
    return _collection;
}


@end
