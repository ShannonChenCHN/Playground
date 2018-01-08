//
//  ViewController.m
//  NavigationControllerCrashTest
//
//  Created by ShannonChen on 2017/12/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationController+SafeTransition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 1000; i++) {
        NSLog(@"测试");
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // http://madordie.leanote.com/post/ruhezhengquedelianxutuixinyemian
    // 当苹果在iPhone5C iOS7.1.2中Push时给出的警告：“nested push animation can result in corrupted navigation bar. Finishing up a navigation transition in an unexpected state. Navigation Bar subview tree might get corrupted.”这说明这个不安全的操作可能会导致应用Crash，Crash统计系统统计的原因为：“Can't add self as subview”。
    // 当 pop 返回到该页面时，pop 动画还未完成又 push 的话，就会导致崩溃
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

- (IBAction)push:(id)sender {
    
    
    // https://stackoverflow.com/questions/19560198/ios-app-error-cant-add-self-as-subview
    [self.navigationController pushViewController:[ViewController new] animated:YES];
    [self.navigationController pushViewController:[ViewController new] animated:NO];
    [self.navigationController pushViewController:[ViewController new] animated:YES];
    [self.navigationController pushViewController:[ViewController new] animated:NO];
    [self.navigationController pushViewController:[ViewController new] animated:YES];
    [self.navigationController pushViewController:[ViewController new] animated:NO];
    
}




@end
