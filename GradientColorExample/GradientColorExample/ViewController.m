//
//  ViewController.m
//  GradientColorExample
//
//  Created by ShannonChen on 2017/9/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Gradient.h"
#import "SCCustomView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) SCCustomView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customView = [[SCCustomView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    self.customView.center = CGPointMake(self.view.bounds.size.width * 0.5, 150);
    [self.view addSubview:self.customView];

    [self setupBackgroundColor];
}


- (void)setupBackgroundColor {
    
    
    UIImage *bgImage = [UIImage imageWithGradientStyle:UIGradientStyleTopLeftToBottomRight
                                                 frame:self.button.bounds
                                                colors:@[[UIColor colorWithHexString:@"ff4d85"],
                                                         [UIColor colorWithHexString:@"ff5a5e"]]];
    [self.button setBackgroundImage:bgImage forState:UIControlStateNormal];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.customView.resized = !self.customView.isResized;
}


@end
