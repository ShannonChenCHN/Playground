//
//  AppDelegate.m
//  WebViewDemo
//
//  Created by ShannonChen on 2017/5/9.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "AppDelegate.h"
#import "UIWebViewController.h"
#import "WKWebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.scheme isEqualToString:@"webviewdemo"]) {
        
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        UINavigationController *navigationController = tabBarController.selectedViewController;
        
        UIViewController *controller = [navigationController.viewControllers.firstObject.class new];
        controller.navigationItem.title = @"New Web View";
        controller.hidesBottomBarWhenPushed = YES;
        
        [navigationController pushViewController:controller animated:YES];

    }
    return YES;
}


@end
