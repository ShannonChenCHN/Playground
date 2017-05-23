//
//  WKWebViewMessageHandler.m
//  WebViewDemo
//
//  Created by ShannonChen on 2017/5/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "WKWebViewMessageHandler.h"

@implementation WKWebViewMessageHandler

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)delegate {
    
    if (self = [super init]) {
        _delegate = delegate;
    }
    
    return self;
}

#pragma mark - <WKScriptMessageHandler>
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
