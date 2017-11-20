//
//  ThumbnailViewController.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/11/12.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ThumbnailViewController.h"

@interface ThumbnailViewController ()

@end

@implementation ThumbnailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Files";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)done {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
