//
//  JSBridgeViewController.m
//  WebViewJavaScriptDemo
//
//  Created by ShannonChen on 2017/7/3.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "JSBridgeViewController.h"
#import <WebViewJavascriptBridge.h>

#import "BirthdayPickerViewController.h"

@interface JSBridgeViewController ()
    
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation JSBridgeViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    
    __weak typeof(self) weakSelf = self;
    [self.bridge registerHandler:@"requestLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"上海市浦东新区张江高科");
    }];
    
    [self.bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *shareContent = [NSString stringWithFormat:@"标题：%@\n 内容：%@ \n url：%@",data[@"title"], data[@"content"], data[@"url"]];
        [self showAlertViewWithTitle:@"调用原生分享菜单" message:shareContent];
    }];
    
    [self.bridge registerHandler:@"chooseADay" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        BirthdayPickerViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"BirthdayPickerViewController"];
        controller.completionHandler = ^(NSString *birthday) {
            responseCallback(birthday);
        };
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [weakSelf.navigationController presentViewController:navigationController animated:YES completion:NULL];
    
    }];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WebViewTest_02" ofType:@"html"];
    NSString *HTMLString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:HTMLString baseURL:nil];
    
}
    
- (IBAction)callJavaScript {
    
    [self.bridge callHandler:@"share" data:nil responseCallback:^(id responseData) {
        NSString *shareContent = [NSString stringWithFormat:@"标题：%@\n 内容：%@ \n url：%@", responseData[@"title"], responseData[@"content"], responseData[@"url"]];
        [self showAlertViewWithTitle:@"调用原生分享菜单" message:shareContent];
    }];
    
}
    
#pragma mark - Action
    
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}
    
    
@end
