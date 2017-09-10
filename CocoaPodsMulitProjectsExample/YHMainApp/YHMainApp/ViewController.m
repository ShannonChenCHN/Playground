//
//  ViewController.m
//  YHMainApp
//
//  Created by ShannonChen on 2017/3/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking.h>

#import <YHLogger.h>
#import <NetworkTest.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [YHLogger log:@"OK"];
    
    
    NetworkTest *test = [[NetworkTest alloc] init];
    [test test];
}



@end
