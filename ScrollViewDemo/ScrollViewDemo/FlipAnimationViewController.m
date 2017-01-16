//
//  FlipAnimationViewController.m
//  ScrollViewDemo
//
//  Created by ShannonChen on 2017/1/16.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "FlipAnimationViewController.h"

@interface FlipAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *controlButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FlipAnimationViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"FlipAnimationDemo";
}

#pragma mark - Event Response
- (IBAction)controlButtonSelectedAction:(id)sender {
    
    // 顺时针旋转90°
    [UIView animateWithDuration:2 animations:^{
        
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI_2);
    }];
    
    // 水平翻转180°
    [UIView animateWithDuration:2  delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.imageView.transform = CGAffineTransformScale(self.imageView.transform, -1.0, 1.0);
    } completion:NULL];
    
}


@end
