//
//  ViewController.m
//  WebViewJavaScriptDemo
//
//  Created by ShannonChen on 2017/7/3.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>
    
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WebViewTest_01" ofType:@"html"];
    NSString *HTMLString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:HTMLString baseURL:nil];
    
}
    
- (IBAction)callJavaScript {
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"share()"];

}

#pragma mark - <UIWebViewDelegate>
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = request.URL;
    
    if ([url.scheme isEqualToString:@"webviewdemo"]) {
        
        if ([url.host isEqualToString:@"getLocation"]) {
            
            NSString *locationInfo = [NSString stringWithFormat:@"setLocation('%@')", @"上海市浦东新区张江高科"];
            [webView stringByEvaluatingJavaScriptFromString:locationInfo];
            
        } else if ([url.host isEqualToString:@"share"]) {
            [self showAlertViewWithTitle:@"调用原生分享菜单" message:url.query];
            
        } else {
            [self showAlertViewWithTitle:@"提示" message:@"测试"];
        }
        return NO;
    }
    
    return YES;
}
    
    
#pragma mark - Action
    
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

@end
