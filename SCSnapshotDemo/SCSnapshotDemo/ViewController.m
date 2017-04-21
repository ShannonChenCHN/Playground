//
//  ViewController.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

#import "SCSnapshotContent.h"
#import "SCSnapshotManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *generateButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.generateButton.layer.borderColor = [UIColor cyanColor].CGColor;
    self.generateButton.layer.borderWidth = 1;
    self.generateButton.layer.cornerRadius = 2;
    
    SCSnapshotContent *content = [[SCSnapshotContent alloc] init];
    content.posterName = @"ShannonChen";
    content.posterAvatarURLString = @"";
    content.userTagDescription
    
    SCSnapshotManager *snapshotManager = [[SCSnapshotManager alloc] init];
    [snapshotManager generateSnapshotWithContent:content completionHander:^(UIImage * _Nullable snapshot) {
        
    }];
}




@end
