//
//  ViewController.m
//  GradientColorExample
//
//  Created by ShannonChen on 2017/9/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Gradient.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}


- (void)viewDidLayoutSubviews {
    
//    self.button.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopLeftToBottomRight
//                                                      withFrame:self.button.bounds
//                                                      andColors:@[[UIColor colorWithHexString:@"ff4d85"],
//                                                                  [UIColor colorWithHexString:@"ff5a5e"]]];
    
    UIImage *bgImage = [UIImage imageWithGradientStyle:UIGradientStyleTopLeftToBottomRight
                                             withFrame:self.button.bounds
                                             andColors:@[[UIColor colorWithHexString:@"ff4d85"],
                                                         [UIColor colorWithHexString:@"ff5a5e"]]];
    [self.button setBackgroundImage:bgImage forState:UIControlStateNormal];
}


@end
