//
//  DFWT_AddOutContactsController.m
//  DFWTProject
//
//  Created by Administrator on 2022/10/26.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_AddOutContactsController.h"
#import "DFWT_QRCodeController.h"
#import "CustomSearchTextField.h"
@interface DFWT_AddOutContactsController ()
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet CustomSearchTextField *searchTF;
@property (weak, nonatomic) IBOutlet UIView *greatGroupView;
@property (weak, nonatomic) IBOutlet UIView *scanView;

@end

@implementation DFWT_AddOutContactsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    self.navigationItem.title = @"添加外部联系人";
    self.searchView.layer.masksToBounds = YES;
    self.searchView.layer.cornerRadius = 4;
    [self.greatGroupView setTapActionWithBlock:^{
            
    }];
    [self.scanView setTapActionWithBlock:^{
        DFWT_QRCodeController *vc = [[DFWT_QRCodeController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }];
}

@end
