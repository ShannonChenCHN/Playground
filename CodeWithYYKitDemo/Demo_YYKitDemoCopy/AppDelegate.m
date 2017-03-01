//
//  AppDelegate.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/1.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "AppDelegate.h"
#import "MTRootViewController.h"

#pragma mark - /////////////////////////// MTExampleNavBar ///////////////////////////// -
@interface MTExampleNavBar : UINavigationBar
@end
@implementation MTExampleNavBar {
    CGSize _previousSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
    size = [super sizeThatFits:size];
    if ([UIApplication sharedApplication].statusBarHidden) { // 隐藏状态栏时，手动设置高度
        size.height = 64;
    }
    return size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGSizeEqualToSize(self.bounds.size, _previousSize)) { // 如果尺寸发生改变才重设尺寸
        _previousSize = self.bounds.size;
#warning ???
//        [self.layer removeAllAnimations];
//        [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer *layer, NSUInteger idx, BOOL *stop) {
//            [layer removeAllAnimations];
//        }];
    }
}
@end


#pragma mark - /////////////////////////// MTExampleNavController ///////////////////////////// -
@interface MTExampleNavController : UINavigationController
@end
@implementation MTExampleNavController
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end

#pragma mark - /////////////////////////// AppDelegate ///////////////////////////// -
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MTRootViewController *rootVC = [MTRootViewController new];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MTExampleNavController *nav = [[MTExampleNavController alloc] initWithNavigationBarClass:[MTExampleNavBar class] toolbarClass:nil];
    if ([nav respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
#warning ???
//        nav.automaticallyAdjustsScrollViewInsets = NO;
    }
    [nav pushViewController:rootVC animated:NO];
    
    self.rootViewController = nav; // 设置导航控制器为根控制器
    self.window.rootViewController = self.rootViewController;
    self.window.backgroundColor = [UIColor grayColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
