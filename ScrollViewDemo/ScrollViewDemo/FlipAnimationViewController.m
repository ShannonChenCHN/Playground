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
    
    // 水平翻转180°？
    [UIView animateWithDuration:2  delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         // MARK: 这里的 CGAffineTransformScale 应该是用来缩放的，要翻转的话推荐用 flip animation，貌似自定义 transform 参数也可以实现，但是比较麻烦
         // http://stackoverflow.com/questions/9032331/ios-flip-animation-only-for-specific-view
         // https://segmentfault.com/q/1010000000134502
        self.imageView.transform = CGAffineTransformScale(self.imageView.transform, -1.0, 1.0);
    } completion:NULL];
    
}


@end
