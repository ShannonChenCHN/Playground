//
//  UIWebViewController.m
//  WebViewDemo
//
//  Created by ShannonChen on 2017/5/9.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "UIWebViewController.h"

@interface UIWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation UIWebViewController

- (void)dealloc {
    /*
     Before releasing an instance of UIWebView for which you have set a delegate, you must first set its delegate property to nil. This can be done, for example, in your dealloc method.
     https://developer.apple.com/reference/uikit/uiwebview/1617937-delegate?language=objc
     */
    self.webView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WebViewTest" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path isDirectory:NO];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


#pragma mark - <UIWebViewDelegate>
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = request.URL;
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}


@end
