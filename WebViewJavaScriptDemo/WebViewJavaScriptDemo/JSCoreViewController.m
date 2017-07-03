//
//  JSCoreViewController.m
//  WebViewJavaScriptDemo
//
//  Created by ShannonChen on 2017/7/3.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "JSCoreViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


#define  dispatch_safe_main_queue(block)      \
    if ([NSThread currentThread].isMainThread) {\
        block();\
    } else { \
        dispatch_sync(dispatch_get_main_queue(), ^{\
        block();\
        }); \
    }

// 暴露给 h5 页面的方法
@protocol JavaScriptCoreHandler <JSExport>
    
- (void)requestLocation;
    
@end



@interface JSCoreViewController () <UIWebViewDelegate, JavaScriptCoreHandler>
    
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) JSContext *jsContext;

@end

@implementation JSCoreViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WebViewTest_03" ofType:@"html"];
    NSString *HTMLString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:HTMLString baseURL:nil];
    
}
    
    
- (IBAction)callJavaScript {
    
    [self.jsContext evaluateScript:@"shareAction()"];
}
    
#pragma mark - <UIWebViewDelegate>
    
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"WebViewDemo"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    __weak typeof(self) weakSelf = self;
    
    // JS 调用原生的 greeting
    self.jsContext[@"greeting"] = ^(){
        NSLog(@"是主线程吗？%i", [NSThread currentThread].isMainThread);
        
        NSArray <JSValue *> *args = [JSContext currentArguments];
        if (args.count < 1) return;
        
        NSString *message = [args.firstObject toString];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf showAlertViewWithTitle:@"打招呼" message:message];
        });
        
    };
    
    
    // JS 调用原生的分享
    self.jsContext[@"share"] = ^(){
        NSArray <JSValue *> *args = [JSContext currentArguments];
        
        NSString *title = args.count > 0 ? [args.firstObject toString] : @"";
        NSString *content = args.count > 1 ? [args[1] toString] : @"";
        NSString *url = args.count > 2 ? [args[2] toString] : @"";
        NSString *shareContent = [NSString stringWithFormat:@"标题：%@\n 内容：%@ \n url：%@", title, content, url];
        
        
        dispatch_safe_main_queue(^{
            [weakSelf showAlertViewWithTitle:@"调用原生分享菜单" message:shareContent];
        });
        
            
        
    };
}
    
#pragma mark - <JavaScriptCoreHandler>
    
- (void)requestLocation {
    
    NSLog(@"当前是主线程吗？%i", [NSThread currentThread].isMainThread);
    
//        // 方式 1
//        JSValue *picCallback = self.jsContext[@"setLocation"];
//        [picCallback callWithArguments:@[@"上海市浦东新区张江高科"]];
    
    // 方式 2
    NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')", @"上海市浦东新区张江高科"];
    [[JSContext currentContext] evaluateScript:jsStr];
    
}
    

    
#pragma mark - Action
    
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}
    
    
@end
