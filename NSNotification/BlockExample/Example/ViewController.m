//
//  ViewController.m
//  Example
//
//  Created by ShannonChen on 2018/2/1.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)pushDetailViewController:(id)sender {
    
    [self.navigationController pushViewController:[DetailViewController new] animated:YES];
}


@end
