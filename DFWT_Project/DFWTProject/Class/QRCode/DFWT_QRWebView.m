

#import "DFWT_QRWebView.h"
#import <WebKit/WebKit.h>

@interface DFWT_QRWebView () <WKNavigationDelegate, WKUIDelegate>
/// WKWebView
@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation DFWT_QRWebView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.wkWebView];
    }
    return self;
}

+ (instancetype)webViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.bounds];
        _wkWebView.navigationDelegate = self;
    }
    return _wkWebView;
}


#pragma mark - - - 加载的状态回调（WKNavigationDelegate）
/// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (self.SGQRCodeDelegate && [self.SGQRCodeDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.SGQRCodeDelegate webViewDidStartLoad:self];
    }
}
/// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (self.SGQRCodeDelegate && [self.SGQRCodeDelegate respondsToSelector:@selector(webView:didCommitWithURL:)]) {
        [self.SGQRCodeDelegate webView:self didCommitWithURL:self.wkWebView.URL];
    }
    
    self.navigationItemTitle = self.wkWebView.title;
}
/// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.navigationItemTitle = self.wkWebView.title;
    if (self.SGQRCodeDelegate && [self.SGQRCodeDelegate respondsToSelector:@selector(webView:didFinishLoadWithURL:)]) {
        [self.SGQRCodeDelegate webView:self didFinishLoadWithURL:self.wkWebView.URL];
    }
}
/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (self.SGQRCodeDelegate && [self.SGQRCodeDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.SGQRCodeDelegate webView:self didFailLoadWithError:error];
    }
}

/// 加载 web
- (void)loadRequest:(NSURLRequest *)request {
    [self.wkWebView loadRequest:request];
}
/// 加载 HTML
- (void)loadHTMLString:(NSString *)HTMLString {
    [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
}
/// 刷新数据
- (void)reloadData {
    [self.wkWebView reload];
}

@end
