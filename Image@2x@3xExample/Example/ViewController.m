//
//  ViewController.m
//  Example
//
//  Created by ShannonChen on 2018/5/25.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (IBAction)push:(id)sender {
    
    ViewController *vc = [[ViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"%@", @(self.navigationController.viewControllers.count)];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
