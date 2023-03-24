
#import "DFWT_QRCodeController.h"
#import "SGQRCode.h"
#import "DFWT_ScanSuccessController.h"

@interface DFWT_QRCodeController () {
    SGQRCodeManager *manager;
}
@property (nonatomic, strong) SGQRCodeScanView *scanView;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
@end

@implementation DFWT_QRCodeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /// 二维码开启方法
    [manager startRunningWithBefore:nil completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanView removeTimer];
    [self removeFlashlightBtn];
    [manager stopRunning];
}

- (void)dealloc {
    NSLog(@"WCQRCodeVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [SGQRCodeManager QRCodeManager];
    [self setupQRCodeScan];
    [self setupNavigationBar];
    [self.view addSubview:self.scanView];
    [self.view addSubview:self.promptLabel];
    [self setLayout];
}

- (void)setupQRCodeScan {
    BOOL isCameraDeviceRearAvailable = manager.isCameraDeviceRearAvailable;
    if (isCameraDeviceRearAvailable == NO) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    manager.openLog = YES;
    manager.brightness = YES;
    [manager scanWithController:self resultBlock:^(SGQRCodeManager *manager, NSString *result) {
        if (result) {
            [manager stopRunning];
            [manager playSoundName:@"SGQRCode.bundle/QRCodeScanEndSound.caf"];
            DFWT_ScanSuccessController *vc = [[DFWT_ScanSuccessController alloc]init];
            if ([result hasPrefix:@"http"]) {
                vc.jump_URL = result;
            }else{
                vc.jump_bar_code = result;
            }
            [weakSelf.navigationController pushViewController:vc animated:NO];
        }
    }];
    [manager scanWithBrightnessBlock:^(SGQRCodeManager *manager, CGFloat brightness) {
        if (brightness < - 1) {
            [weakSelf.view addSubview:weakSelf.flashlightBtn];
        } else {
            if (weakSelf.isSelectedFlashlightBtn == NO) {
                [weakSelf removeFlashlightBtn];
            }
        }
    }];
}

- (void)setLayout{
    [self.scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.center.equalTo(self.view);
        make.height.mas_equalTo(20);
    }];
}

- (void)removeScanningView {
    [self.scanView removeTimer];
    [self.scanView removeFromSuperview];
    self.scanView = nil;
}

#pragma mark - - - 闪光灯按钮
- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat flashlightBtnW = 30;
        CGFloat flashlightBtnH = 30;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.55 * self.view.frame.size.height;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightCloseImage"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [manager turnOnFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->manager turnOffFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"扫一扫";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
}

- (void)rightBarButtonItenAction {
    __weak typeof(self) weakSelf = self;
    
    [manager readWithResultBlock:^(SGQRCodeManager *manager, NSString *result) {
        [self showHUDMessage:@"正在处理..."];
        if (result == nil) {
            DEF_Log(@"暂未识别出二维码");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showHUDMessage:@"未发现二维码/条形码"];
             });
        } else {
            DFWT_ScanSuccessController *vc = [[DFWT_ScanSuccessController alloc]init];
            if ([result hasPrefix:@"http"]) {
                vc.jump_URL = result;
            }else{
                vc.jump_bar_code = result;
            }
            [weakSelf.navigationController pushViewController:vc animated:NO];
        }
    }];
    
    if (manager.albumAuthorization == YES) {
        [self.scanView removeTimer];
    }
    [manager albumDidCancelBlock:^(SGQRCodeManager *manager) {
        [weakSelf.scanView addTimer];
    }];
}


- (SGQRCodeScanView *)scanView {
    if (!_scanView) {
        _scanView = [[SGQRCodeScanView alloc] initWithFrame:CGRectZero];
    }
    return _scanView;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text = @"将二维码/条码放入框内, 即可自动扫描";
    }
    return _promptLabel;
}

@end
