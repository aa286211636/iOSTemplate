
//  DFWT_QRWebView 使用注意点：
//  如果 self.navigationController.navigationBar.translucent = NO；或者导航栏不存在; 那么 ZYYL_QRWebView 的 isNavigationBarOrTranslucent属性 必须设置 NO)

#import <UIKit/UIKit.h>
@class DFWT_QRWebView;

@protocol DFWT_QRWebViewDelegate <NSObject>
@optional
/** 页面开始加载时调用 */
- (void)webViewDidStartLoad:(DFWT_QRWebView *)webView;
/** 内容开始返回时调用 */
- (void)webView:(DFWT_QRWebView *)webView didCommitWithURL:(NSURL *)url;
/** 页面加载失败时调用 */
- (void)webView:(DFWT_QRWebView *)webView didFinishLoadWithURL:(NSURL *)url;
/** 页面加载完成之后调用 */
- (void)webView:(DFWT_QRWebView *)webView didFailLoadWithError:(NSError *)error;
@end

@interface DFWT_QRWebView : UIView
/** SGDelegate */
@property (nonatomic, weak) id<DFWT_QRWebViewDelegate> SGQRCodeDelegate;
/** 进度条颜色(默认蓝色) */
@property (nonatomic, strong) UIColor *progressViewColor;
/** 导航栏标题 */
@property (nonatomic, copy) NSString *navigationItemTitle;
/** 导航栏存在且有穿透效果(默认导航栏存在且有穿透效果) */
@property (nonatomic, assign) BOOL isNavigationBarOrTranslucent;

/** 类方法创建 ZYYL_QRWebView */
+ (instancetype)webViewWithFrame:(CGRect)frame;
/** 加载 web */
- (void)loadRequest:(NSURLRequest *)request;
/** 加载 HTML */
- (void)loadHTMLString:(NSString *)HTMLString;
/** 刷新数据 */
- (void)reloadData;

@end
