

#import "DFWT_ScanSuccessController.h"
#import "DFWT_QRWebView.h"

@interface DFWT_ScanSuccessController () <DFWT_QRWebViewDelegate>
@property (nonatomic , strong) DFWT_QRWebView *webView;
@end

@implementation DFWT_ScanSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.jump_bar_code) {
        [self setupLabel];
    } else {
        [self setupWebView];
    }
}

// 添加Label，加载扫描过来的内容
- (void)setupLabel {
    // 提示文字
    UILabel *prompt_message = [[UILabel alloc] init];
        prompt_message.text = @"您扫描的条形码结果如下： ";
    prompt_message.textColor = DEF_APPCOLOR;
    prompt_message.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:prompt_message];
    [prompt_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-30);
        make.height.mas_equalTo(20);
    }];
    
    // 扫描结果
    UILabel *label = [[UILabel alloc] init];
    label.text = self.jump_bar_code;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(prompt_message.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    self.webView = [DFWT_QRWebView webViewWithFrame:self.view.bounds];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.jump_URL]]];
    _webView.SGQRCodeDelegate = self;
    [self.view addSubview:_webView];
}

- (void)webView:(DFWT_QRWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    self.title = webView.navigationItemTitle;
}

@end
