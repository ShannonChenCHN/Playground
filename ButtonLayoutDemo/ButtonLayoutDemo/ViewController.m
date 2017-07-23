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
    
    // 方案一
    self.button1.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.button1 sc_setLayoutStyle:SCButtonLayoutStyleImageTop spacing:20];
    
    // 方案二
    self.button2.interTitleImageSpacing = 20;
    self.button2.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 方案三
    self.button3.interTitleImageSpacing = 20;
    self.button3.imagePosition = SCCustomButtonImagePositionTop;
    self.button3.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}



@end
