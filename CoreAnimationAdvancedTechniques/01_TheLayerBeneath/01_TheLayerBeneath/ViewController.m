//
//  ViewController.m
//  01_TheLayerBeneath
//
//  Created by ShannonChen on 2016/11/27.
//  Copyright © 2016年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    /*
     // 1.layer tree
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.layerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.layerView];
    
    CALayer *blueLayer =  [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:blueLayer];
    
    */
    
     // 2.1 the content image
     self.layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
     self.layerView.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:self.layerView];
    
    UIImage *image = [UIImage imageNamed:@"Snowman.png"];
    self.layerView.layer.contents = (__bridge id) image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityCenter;
    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;//image.scale;
    self.layerView.clipsToBounds = YES;
    
}


@end
