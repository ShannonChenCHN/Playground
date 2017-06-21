//
//  WKWebViewController.m
//  WebViewDemo
//
//  Created by ShannonChen on 2017/5/9.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "WKWebViewMessageHandler.h"

#define LogFunctionName     NSLog(@"%s", __FUNCTION__);

@interface WKWebViewController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>


@property (copy, nonatomic) NSURL *URL;
@property (strong, nonatomic) WKWebViewConfiguration *configuration;
@property (weak, nonatomic) WKWebView *webView;
@property (weak, nonatomic) WKWebViewMessageHandler *messageHandler;


@end

@implementation WKWebViewController

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"loading"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // userContentController
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
    NSString *getInnerHTMLTextScriptSource = @"window.webkit.messageHandlers.observe.postMessage(document.body.innerText);";
    WKUserScript *getInnerHTMLTextUserScript = [[WKUserScript alloc] initWithSource:getInnerHTMLTextScriptSource injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    NSString *changeBgColorScriptSource = @"document.body.style.background = \"#ff5c60\";";
    WKUserScript *changeBgColorScript = [[WKUserScript alloc] initWithSource:changeBgColorScriptSource injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [userContentController addUserScript:getInnerHTMLTextUserScript];
    [userContentController addUserScript:changeBgColorScript];
    
    // WKWebView causes my view controller to leak
    // https://stackoverflow.com/questions/26383031/wkwebview-causes-my-view-controller-to-leak
    WKWebViewMessageHandler *handler = [[WKWebViewMessageHandler alloc] initWithDelegate:self];
    [userContentController addScriptMessageHandler:handler name:@"testHandler"];
    [userContentController addScriptMessageHandler:handler name:@"observe"];
    
    WKPreferences* preferences = [[WKPreferences alloc] init];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    
    if (self.configuration == nil) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        configuration.preferences = preferences;
        self.configuration = configuration;
    }
    
    // 创建 WKWebView
    WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:webView];
    self.webView = webView;
    
    // 加载网页
//    if (self.URL) {
//        [self loadRequestWithURL:self.URL];
//    } else {
        [self loadFileURL];
//    }
    
    // 读取 User-Agent
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"User-Agent: %@", result);
    }];
    
    // Go Back/Forward and Progress
    NSArray *webViewKeyPathsToObserve = @[@"loading", @"estimatedProgress"];
    for (NSString *keyPath in webViewKeyPathsToObserve) {
        [self.webView addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    
    // Print the HTML text
    [self.webView evaluateJavaScript:@"document.documentElement.outerHTML.toString()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"HTML Text: %@", result);
    }];
}


#pragma mark - Load Data
- (void)loadHTML {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WebViewTest" ofType:@"html"];
    NSString *HTMLString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:HTMLString baseURL:nil];
}

- (void)loadFileURL {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WebViewTest" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path isDirectory:NO];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)loadRemoteURL {

    NSURL *url = [NSURL URLWithString:@"https://m.baidu.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"Wolverine" forHTTPHeaderField:@"X-Men-Header"];
    [request setValue:@"Custom User Agent" forHTTPHeaderField:@"User-Agent"];
    [self.webView loadRequest:request];
}

- (void)loadRequestWithURL:(NSURL *)URL {
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (keyPath == nil) {
        return;
    }
    
    if ([keyPath isEqualToString:@"loading"]) {
        
        // If you have back and forward buttons, then here is the best time to enable it
//        backButton.enabled = self.webView.canGoBack;
//        forwardButton.enabled = self.webView.canGoForward;
        
    } else if ([keyPath isEqualToString:@"loading"]) {
        
        // If you are using a `UIProgressView`, this is how you update the progress
//        progressView.hidden = (self.webView.estimatedProgress == 1);
//        progressView.progress = self.webView.estimatedProgress;
        
    }
}

/*
 问题：
 1. 什么是 WKNavigation？一个 WKNavigation 对象代表什么？什么是 navigation？
 2. WKNavigationAction 是用来干什么的？
 3. WKNavigationResponse 是用来干什么的？
 4. authentication challenge 是什么个流程？
 5. 什么时候才会出现 “web view’s web content process is terminated”？
 6. 一个网页的加载的完整过程？
 7. WKUserContentController 是什么？WKScriptMessage 又是什么？
 8. WKWebView 所带来的好处，为什么我要用 WKWebView 取代 UIWebView？
 9. web 开发中的 frame 指的是什么？ window 又是指什么？
 10.我们已经有 evaluateJavaScript: 方法了，为什么还需要 WKUserScript？
 */

#pragma mark - <WKScriptMessageHandler>

// Invoked when a script message is received from a webpage.
// iOS (8.0 and later)
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    // Using JavaScript with WKWebView in iOS 8 http://www.joshuakehn.com/2014/10/29/using-javascript-with-wkwebview-in-ios-8.html
    // Catch Javascript Event in iOs WKWebview with Swift https://stackoverflow.com/questions/34574864/catch-javascript-event-in-ios-wkwebview-with-swift/34575373#34575373
    
    
    NSLog(@"message name: %@, message body(%@): %@", message.name, NSStringFromClass([message.body class]), message.body);
    
    if ([message.name isEqualToString:@"testHandler"] &&
        [message.body isKindOfClass:[NSDictionary class]]) {
        
        Class aClass = NSClassFromString(message.body[@"className"]);
        if (aClass) {
            id object = [aClass new];
            SEL selector = NSSelectorFromString(message.body[@"functionName"]);
            if ([object respondsToSelector:selector]) {
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [object performSelector:selector];
#pragma clang diagnostic pop
            }
        }
    }
}



#pragma mark - <WKNavigationDelegate>

// Called when web content begins to load in a web view.
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    LogFunctionName;
}

// Called when the web view begins to receive web content.
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    LogFunctionName;
}


// Called when the navigation is complete.
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    LogFunctionName;
    
    
    // WKWebView didn't finish loading, when didFinishNavigation is called - Bug in WKWebView?
    // https://stackoverflow.com/questions/30291534/wkwebview-didnt-finish-loading-when-didfinishnavigation-is-called-bug-in-wkw?rq=1
    
}

// Called when an error occurs during navigation.
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    LogFunctionName;
    
    [self handleError:error];
    

}

// Called when an error occurs while the web view is loading content
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    LogFunctionName;
    
    [self handleError:error];
}

// Decides whether to allow or cancel a navigation.
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    LogFunctionName;
    
    NSURL *url = navigationAction.request.URL;
    
    if (decisionHandler) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}

// Decides whether to allow or cancel a navigation after its response is known.
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    LogFunctionName;
    
    if (decisionHandler) {
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
    
}

// Called when a web view receives a server redirect.
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    LogFunctionName;
}

// Called when the web view needs to respond to an authentication challenge.
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    LogFunctionName;
    
    if (completionHandler) {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
    
}

// MARK: ??? Called when the web view’s web content process is terminated
// MARK: iOS (9.0 and later)
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    LogFunctionName;
    
    // What actions trigger webViewWebContentProcessDidTerminate function  https://stackoverflow.com/questions/39039840/what-actions-trigger-webviewwebcontentprocessdidterminate-function
    // WKWebView goes blank after memory warning  https://stackoverflow.com/questions/27565301/wkwebview-goes-blank-after-memory-warning/41706111#41706111
    
    [self.webView reload];
}


#pragma mark - <WKUIDelegate>

// Creates a new web view.
// The web view returned must be created with the specified configuration. WebKit loads the request in the returned web view.
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    // http://stackoverflow.com/a/26683888/7088321
    // If the page uses window.open() or target="_blank", open the page in a new view controller.
    WKWebViewController *wkWebViewController = [[WKWebViewController alloc] init];
    wkWebViewController.URL = navigationAction.request.URL;
    wkWebViewController.navigationItem.title = @"New WKWebView";
    wkWebViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wkWebViewController animated:YES];
    
    return wkWebViewController.webView;
    
    // or
    /*
     
     if (!navigationAction.targetFrame.isMainFrame) {
     [webView loadRequest:navigationAction.request];
     }
     
     return nil;
     
     */
    
}


// MARK: iOS (9.0 and later)
// Notifies your app that the DOM window closed successfully
- (void)webViewDidClose:(WKWebView *)webView {
    
    // Close a webview by call `window.close();`
    // Using UIWebView there is no way of achieving this without injecting some JavaScript
    // https://stackoverflow.com/questions/31842899/handling-window-close-in-javascript-through-uiwebview-obj-c/36143847#36143847
    
    [self.navigationController popViewControllerAnimated:YES];
}


// Alert Dialog Box
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // MARK: Must call completion handler
        if (completionHandler) {
            completionHandler();
        }
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}


// Confirmation Dialog Box
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // MARK: Must call completion handler
        if (completionHandler) {
            completionHandler(YES);
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // MARK: Must call completion handler
        if (completionHandler) {
            completionHandler(NO);
        }
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}

// Prompt Dialog Box
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = defaultText;
    }];
    
    __weak typeof(UIAlertController) *weakAlert = alertController;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // MARK: Must call completion handler
        if (completionHandler) {
            if (weakAlert.textFields.count > 0) {
                completionHandler(weakAlert.textFields.firstObject.text);
            }
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // MARK: Must call completion handler
        if (completionHandler) {
            completionHandler(nil);
        }
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}


/* 
   iOS 10 Link Preview API in WKWebView https://webkit.org/blog/7016/ios-10-link-preview-api-in-wkwebview/
   How can I use link preview in WKWebView on elements with no href? https://stackoverflow.com/questions/41554967/how-can-i-use-link-preview-in-wkwebview-on-elements-with-no-href
 */
// MARK: The following methods are only available on iOS (10.0 and later)
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {return YES;}

- (nullable UIViewController *)webView:(WKWebView *)webView
    previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo
                        defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions {return [UIViewController new];}

- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController {}



#pragma mark - Private Methods 
- (void)handleError:(NSError *)error {

    
    NSString *failingURL = error.userInfo[@"NSErrorFailingURLStringKey"];
    NSURL *urlToOpen = [NSURL URLWithString:failingURL];
    
    if (urlToOpen && [[UIApplication sharedApplication] canOpenURL:urlToOpen]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] openURL:urlToOpen];
#pragma clang diagnostic pop
        
        /*
         // MARK: This method is only available on iOS 10 and later
         [[UIApplication sharedApplication] openURL:urlToOpen options:@{} completionHandler:^(BOOL success) {
         NSLog(@"%@", success ? @"Open URL successfully" : @"Open URL failed");
         }];
         */
    }
}

@end
