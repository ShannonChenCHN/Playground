//
//  WKWebViewMessageHandler.h
//  WebViewDemo
//
//  Created by ShannonChen on 2017/5/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <WebKit/WebKit.h>

// http://www.jianshu.com/p/6ba2507445e4
// WKWebView causes my view controller to leak https://stackoverflow.com/questions/26383031/wkwebview-causes-my-view-controller-to-leak
@interface WKWebViewMessageHandler : NSObject <WKScriptMessageHandler>

@property (weak, nonatomic) id <WKScriptMessageHandler> delegate;

- (instancetype)initWithDelegate:(id <WKScriptMessageHandler>)delegate;

@end
