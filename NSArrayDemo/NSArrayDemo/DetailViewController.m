//
//  DetailViewController.m
//  NSArrayDemo
//
//  Created by ShannonChen on 2017/9/14.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "DetailViewController.h"
#import "CustomModel.h"

@interface DetailViewController ()

@property (strong, nonatomic) NSArray <CustomModel *> *array2;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    self.array2 = self.array1.mutableCopy;
    
    self.array2 = [[NSMutableArray alloc] initWithArray:self.array1 copyItems:YES];
    
    [self.array2 enumerateObjectsUsingBlock:^(CustomModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 2) {
            model.flag = YES;
            model.name = @"test";
        }
    }];
    
}


@end
