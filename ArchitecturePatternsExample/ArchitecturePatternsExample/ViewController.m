//
//  ViewController.m
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/10.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "SCUserSelfProfileViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


/**
 
 大体架构：
 
 - UserVC 作为业务场景 Scene, 需要展示三种数据, 对应的就有三个 MVC
 - 这三个 MVC 负责各自模块的数据获取, 数据处理和数据展示
 - UserVC 需要做的就是配置好这三个 MVC, 并在合适的时机通知各自的 C 层进行数据获取
 - 各个 C 层拿到数据后进行相应处理, 处理完成后渲染到各自的 View 上, UserVC 最后将已经渲染好的各个View 进行布局
 
 
 
 **/
    
- (IBAction)pushMVCExampleForSelfScene:(id)sender {
    [self.navigationController pushViewController:[[SCUserSelfProfileViewController alloc] init] animated:YES];
}
    
- (IBAction)pushMVCExampleForOtherScene:(id)sender {
    [self.navigationController pushViewController:[[SCUserProfileViewController alloc] initWithUserId:@"234"] animated:YES];
}


@end
