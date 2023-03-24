//
//  DFWT_MeetPhoneController.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/28.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MeetPhoneController.h"
#import "DFWT_TabController.h"
#import "DFWT_PhoneCell.h"
@interface DFWT_MeetPhoneController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,strong) UIButton *phoneBtn;
@property (nonatomic,strong) UITextField *inputTF;
@property (nonatomic,copy) NSString *inputStr;
@end

@implementation DFWT_MeetPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setLayout];
}

- (void)setUI{
    self.navigationItem.title = @"拨号盘";
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 54, 30);
    [back setImage:[UIImage imageNamed:@"meet_nav_back"] forState:UIControlStateNormal];
    [back setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"meet_nav"] style:UIBarButtonItemStylePlain target:self action:nil];;
    self.navigationItem.rightBarButtonItem = Item;
    [self.view addSubview:self.phoneBtn];
    [self.view addSubview:self.collection];
    [self.view addSubview:self.inputTF];
    self.inputStr = @"";
}

-(void)setLayout{
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(DEF_SCREENH_HEIGHT/5);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.phoneBtn.mas_top).offset(-20);
    }];
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collection.mas_top).offset(-20);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_equalTo(54);
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
 return 12;
}
 
// 设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DFWT_PhoneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFWT_PhoneCell" forIndexPath:indexPath];
    if (indexPath.item < 9 || indexPath.item == 10) {
        if (indexPath.item == 10) {
            [cell.phoneBtn setTitle:@"0" forState:UIControlStateNormal];
        }else{
            [cell.phoneBtn setTitle:[NSString stringWithFormat:@"%ld",indexPath.item + 1] forState:UIControlStateNormal];
        }
        cell.phoneBtn.backgroundColor = DEF_HEXColor(0xF3F2F7);
    }else if(indexPath.item == 9){
        cell.phoneBtn.backgroundColor = [UIColor clearColor];
        [cell.phoneBtn setTitle:@"粘贴" forState:UIControlStateNormal];

    }else if (indexPath.item == 11){
        cell.phoneBtn.backgroundColor = [UIColor clearColor];
        [cell.phoneBtn  setImage:[UIImage imageNamed:@"add_delete"] forState:UIControlStateNormal];
    }
    [cell.phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.phoneBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    DFWT_PhoneCell *newCell = (DFWT_PhoneCell*)cell;
    newCell.layer.cornerRadius = cell.bounds.size.width/2;
    newCell.layer.masksToBounds = YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item < 9){
        self.inputStr = [self.inputStr stringByAppendingString:[NSString stringWithFormat:@"%ld",indexPath.item + 1]];
    }else if (indexPath.item == 10){
        self.inputStr = [self.inputStr stringByAppendingString:@"0"];
    }else if (indexPath.item == 11){
        if(self.inputStr.length){
            self.inputStr = [self.inputStr substringToIndex:self.inputStr.length - 1];
        }
    }
    self.inputTF.text = self.inputStr;
    
}

-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat W = (DEF_SCREEN_WIDTH - 160)/3;
        CGFloat H = W;
        flowLayout.itemSize = CGSizeMake(W,H);
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(15,30,15,30);//一个section 上左下右间隔
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.dataSource = self;
        _collection.delegate = self;
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsVerticalScrollIndicator = NO;
        _collection.scrollEnabled = NO;
        [_collection registerNib:[UINib nibWithNibName:@"DFWT_PhoneCell" bundle:nil] forCellWithReuseIdentifier:@"DFWT_PhoneCell"];
    }
    return _collection;
}

-(UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setTitle:@"普通电话" forState:UIControlStateNormal];
        _phoneBtn.layer.masksToBounds = YES;
        _phoneBtn.layer.cornerRadius = 20;
        _phoneBtn.backgroundColor = DEF_HEXColor(0x0EBE83);
    }
    return _phoneBtn;
}

-(UITextField *)inputTF{
    if (!_inputTF) {
        _inputTF = [[UITextField alloc]init];
        _inputTF.clearButtonMode = UITextFieldViewModeAlways;
        _inputTF.font = [UIFont systemFontOfSize:18];
        _inputTF.textAlignment = NSTextAlignmentRight;
    }
    return _inputTF;
}
@end
