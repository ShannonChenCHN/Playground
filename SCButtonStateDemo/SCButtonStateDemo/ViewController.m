//
//  ViewController.m
//  SCButtonStateDemo
//
//  Created by ShannonChen on 2016/11/10.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonDidTapAction:(UIButton *)button {
    
    
    if (button.state == UIControlStateHighlighted) {  // 从 normal 到  Highlighted
        button.selected = YES;
    }
    else if (button.state == (UIControlStateSelected | UIControlStateHighlighted)) {  // 从 Selected 到 Highlighted
        button.selected = NO;
        button.enabled = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 从 disabled 到 normal、selected
            button.enabled = YES;
            
            if (arc4random() % 2) {
                button.selected = YES;
            }
        });
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
