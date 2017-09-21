//
//  ViewController.m
//  NSArrayDemo
//
//  Created by ShannonChen on 2017/9/14.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "CustomModel.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray <CustomModel *> *array1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array1 = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        CustomModel *model = [[CustomModel alloc] init];
        model.name = [NSString stringWithFormat:@"%@", @(i)];
        model.flag = NO;
        [self.array1 addObject:model];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailViewController *destinationViewController = [segue destinationViewController];
    destinationViewController.array1 = self.array1;
}


@end
