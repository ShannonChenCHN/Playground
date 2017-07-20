//
//  ViewController.m
//  WebViewJavaScriptDemo
//
//  Created by ShannonChen on 2017/7/3.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"


@interface NSString (URLEncode)

- (NSString *)sc_encodedString;

@end

@implementation NSString (URLEncode)

- (NSString *)sc_encodedString {
    NSString *encodedString = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    
    return [encodedString stringByRemovingPercentEncoding];
}

@end

@interface ViewController () <UIWebViewDelegate>
    
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *shareButtonInfo;
@property (strong, nonatomic) NSString *guidesButtonInfo;

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
            
        } else if ([url.host isEqualToString:@"showRightNavButtons"]) {
            if ([url.query containsString:@"buttons="] == NO) {
                return NO;
            }
            NSString *JSONString = [[url.query substringFromIndex:[@"buttons=" length]] sc_encodedString];
            
            // 字符编码
            NSData *data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *JSONSerializationError = nil;
            NSArray *buttons = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&JSONSerializationError];
            
            
            NSMutableArray *buttonItems = [NSMutableArray array];
            [buttons enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull buttonInfo, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx > 1) {
                    *stop = YES;
                }
                
                if ([buttonInfo[@"title"] isKindOfClass:[NSString class]]) {
                    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:buttonInfo[@"title"] style:UIBarButtonItemStylePlain target:self action:@selector(showGuides)];
                    [buttonItems addObject:item];
                    
                    self.guidesButtonInfo = [buttonInfo[@"jsAction"] isKindOfClass:[NSString class]] ? buttonInfo[@"jsAction"] : buttonInfo[@"nativeAction"];
                    
                } else if ([buttonInfo[@"image"] isKindOfClass:[NSString class]]) {
                    NSString *imageName = buttonInfo[@"image"];
                    
                    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
                    [buttonItems addObject:item];
                    
                    self.shareButtonInfo = [buttonInfo[@"jsAction"] isKindOfClass:[NSString class]] ? buttonInfo[@"jsAction"] : buttonInfo[@"nativeAction"];
                }
                
            }];
            
            self.navigationItem.rightBarButtonItems = buttonItems;
            
            return NO;
            
            
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

- (void)share {
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@();", self.shareButtonInfo]];
}

- (void)showGuides {
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@();", self.guidesButtonInfo]];
}

@end
