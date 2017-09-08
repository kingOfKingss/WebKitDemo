//
//  ViewController.m
//  WebViewDemo
//
//  Created by MacBook Pro on 2017/9/7.
//  Copyright © 2017年 MacBook Pro. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface ViewController ()<WKScriptMessageHandler, UIScrollViewDelegate, WKUIDelegate, WKNavigationDelegate>
//@property(nonatomic, weak) UIWebView *webView;
@property(nonatomic, weak) WKWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView = webView;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:webView];
    
    [config.userContentController addScriptMessageHandler:self name:@"showName"];
    webView.allowsBackForwardNavigationGestures = NO;

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"file:///Users/macbookpro/Desktop/vue-demo/index.html"]]];
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.alwaysBounceVertical = NO;
    self.webView.scrollView.alwaysBounceHorizontal = NO;
    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    self.webView = webView;
//    [self.view addSubview:webView];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.65:8074/MyData/EventListForThree?P_Guid=3DBBAB91-B76C-44BA-B041-940F436D91BF&MB_Guid=13346F41-1E62-4F60-A97F-0B0A8A1033C4"]]];
//    [self addCustomActions];
}

- (void)addCustomActions
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [self addScanWithContext:context];
}

- (void)addScanWithContext:(JSContext *)context
{
    context[@"asd"] = ^() {
        NSLog(@"扫一扫啦");
    };
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"showName"]) {
        [self test];
    }
}

- (void)test{
    [self.webView evaluateJavaScript:@"aaa()" completionHandler:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated:
        {
            NSLog(@"WKNavigationTypeLinkActivated");
            break;
        }
        case WKNavigationTypeFormSubmitted:
        {
            NSLog(@"WKNavigationTypeFormSubmitted");
            break;
        }
        case WKNavigationTypeBackForward:
        {
            NSLog(@"WKNavigationTypeBackForward");
            break;
        }
        case WKNavigationTypeReload:
        {
            NSLog(@"WKNavigationTypeReload");
            break;
        }
        case WKNavigationTypeFormResubmitted:
        {
            NSLog(@"WKNavigationTypeFormResubmitted");
            break;
        }
        case WKNavigationTypeOther:
        {
            NSLog(@"WKNavigationTypeOther");
            break;
        }
            
        default:
            break;
    }
    
    NSLog(@"%@", navigationAction.sourceFrame.request.URL);
    NSLog(@"%@", navigationAction.targetFrame.request.URL);
    
//    NSLog(@"%ld", navigationAction.buttonNumber);
    
    NSLog(@"decidePolicyForNavigationAction");
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    NSDictionary *st = ((NSHTTPURLResponse *)navigationResponse.response).allHeaderFields;
    NSLog(@"decidePolicyForNavigationResponse");
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
        NSLog(@"didStartProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"didCommitNavigation");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"didFinishNavigation");
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailNavigation");
}
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
//{
//    NSLog(@"didReceiveAuthenticationChallenge");
//    NSURLCredential *cre = [[NSURLCredential alloc] initWithUser:nil password:nil persistence:NSURLCredentialPersistenceNone];
//
//    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, cre);
//}



- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    WKWebView *webViews = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    [self.view addSubview:webViews];
    return webViews;
}
- (void)webViewDidClose:(WKWebView *)webView
{
    NSLog(@"webViewDidClose");
}
@end
