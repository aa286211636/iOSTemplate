//
//  DFWT_PrivateZoneView.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/9.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_PrivateZoneView.h"
#import "DFWT_CollectionCell.h"
@interface DFWT_PrivateZoneView()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UICollectionView *collection;
@end

@implementation DFWT_PrivateZoneView{
    NSArray *_collectArr;
}

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
    self.backgroundColor = [UIColor whiteColor];
    _collectArr = @[@"上传图片",@"上传视频",@"上传文件",@"文件夹",@"文档",@"PPT",@"表格",@"PDF"];
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
    return cell;
}

// DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"doc_placeholder"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"私人盘仅自己可查看\n换了手机或电脑也能访问";
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:16],
        NSForegroundColorAttributeName:DEF_FONT_GRAY_COLOR
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    // 设置按钮标题
    NSString *buttonTitle = @"创建文档";
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f],
        NSForegroundColorAttributeName:[UIColor whiteColor],
    };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
    
}

-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 20;
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return [UIImage imageWithColor:DEF_HEXColor(0x3F8CFF)];
}

- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView {
    UIButton *button = [scrollView valueForKeyPath:@"emptyDataSetView.button"];
    if (button) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        // Change button width
        for (NSLayoutConstraint *constraint in button.superview.constraints) {
            if (constraint.firstItem == button && constraint.firstAttribute == NSLayoutAttributeLeading) {
                constraint.constant = 60.0;
            } else if (constraint.secondItem == button && constraint.secondAttribute == NSLayoutAttributeTrailing) {
                constraint.constant = 60.0;
            }
        }
        // Change button height
        for (NSLayoutConstraint *constraint in button.constraints) {
            if (constraint.firstItem == button && constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 40.0;
            }
        }
    }
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    [self showActionSheet];
}

- (void)showActionSheet{
    DEF_WeakSelf(self)
    [LEEAlert actionsheet].config
    .LeeAddTitle(^(UILabel * _Nonnull label) {
        label.text = @"新建";
        label.textColor = [UIColor blackColor];
     })
    .LeeMaxWidth(DEF_SCREEN_WIDTH)
    .LeeAddCustomView(^(LEECustomView * _Nonnull custom) {
        weakSelf.collection.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 320);
        [weakSelf.collection reloadData];
        custom.view = weakSelf.collection;
    })
    .LeeCancelAction(@"取消", ^{
    })
    .LeeShow();
}

#pragma mark - 代理方法 Delegate Methods
// 设置分区
 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 return 1;
}
 
// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 return _collectArr.count;
}
 
// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFWT_CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFWT_CollectionCell" forIndexPath:indexPath];
    cell.text = _collectArr[indexPath.item];
    cell.imgName = @"doc_file";
    return cell;
}

-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat W = (DEF_SCREEN_WIDTH - 60)/3;
        CGFloat H = W * 0.8;
        flowLayout.itemSize = CGSizeMake(W,H);
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(15,15,15,15);//一个section 上左下右间隔
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.dataSource = self;
        _collection.delegate = self;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerNib:[UINib nibWithNibName:@"DFWT_CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"DFWT_CollectionCell"];
    }
    return _collection;
}

//懒加载控件
- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.showsVerticalScrollIndicator = NO;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.emptyDataSetSource = self;
        _table.emptyDataSetDelegate = self;
        _table.estimatedRowHeight = 0;
        _table.estimatedSectionHeaderHeight = 0;
        _table.estimatedSectionFooterHeight = 0;
        _table.tableFooterView = [UIView new];
        [_table registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    }
    return _table;
}


@end
