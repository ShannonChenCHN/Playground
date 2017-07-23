//
//  ViewController.m
//  ButtonLayoutDemo
//
//  Created by ShannonChen on 2017/7/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"
#import "SCCustomButton.h"
#import "UIButton+Layout.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet CustomButton *button2;
@property (weak, nonatomic) IBOutlet SCCustomButton *button3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button1.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.button1 sc_setLayoutStyle:SCButtonLayoutStyleImageBottom spacing:20];
    
    UIButton *button = nil;
    // 目标图文间距
    CGFloat interImageTitleSpacing = 5;

    // 图片下移，右移
    button.imageEdgeInsets = UIEdgeInsetsMake(button.titleLabel.frame.size.height + interImageTitleSpacing,
                                            0,
                                            0,
                                            -(button.titleLabel.frame.size.width));
    
    // 文字上移，左移
    button.titleEdgeInsets = UIEdgeInsetsMake(0,
                                            -(button.imageView.frame.size.width),
                                            button.imageView.frame.size.height + interImageTitleSpacing,
                                            0);
    
    self.button2.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    
    self.button3.interTitleImageSpacing = 20;
    self.button3.imagePosition = SCCustomButtonImagePositionTop;
    self.button3.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}



@end
