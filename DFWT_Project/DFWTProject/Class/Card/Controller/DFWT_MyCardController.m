//
//  DFWT_MyCardController.m
//  DFWTProject
//
//  Created by Administrator on 2022/9/1.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "DFWT_MyCardController.h"


@interface DFWT_MyCardController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *nameImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@end

@implementation DFWT_MyCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    self.view.backgroundColor = DEF_TABLEBGCOLOR;
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    [self.nameImgView setImageWithString:self.nameL.text color:DEF_HEXColor(0x0089ff) circular:YES textAttributes:@{
        NSFontAttributeName: [UIFont systemFontOfSize:15],
        NSForegroundColorAttributeName: [UIColor whiteColor]
        }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑名片" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
}

- (void)rightBarButtonItenAction{
    
}
@end
