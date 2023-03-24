//
//  DFWT_LatelyZoneView.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/9.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_LatelyZoneView.h"
#import "DFWT_LatelyCell.h"
@interface DFWT_LatelyZoneView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collection;
@end
@implementation DFWT_LatelyZoneView

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
    [self addSubview:self.collection];
}

-(void)setLayout{
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - 代理方法 Delegate Methods
// 设置分区
 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 return 1;
}
 
// 每个分区上得元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 return 5;
}
 
// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFWT_LatelyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFWT_LatelyCell" forIndexPath:indexPath];
    return cell;
}

-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat W = (DEF_SCREEN_WIDTH - 45)/2;
        CGFloat H = W *0.7;
        flowLayout.itemSize = CGSizeMake(W,H);
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(15,15,15,15);//一个section 上左下右间隔
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.dataSource = self;
        _collection.delegate = self;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerNib:[UINib nibWithNibName:@"DFWT_LatelyCell" bundle:nil] forCellWithReuseIdentifier:@"DFWT_LatelyCell"];
    }
    return _collection;
}


@end
