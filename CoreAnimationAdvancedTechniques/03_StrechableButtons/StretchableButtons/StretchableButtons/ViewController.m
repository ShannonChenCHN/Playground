//
//  ViewController.m
//  StretchableButtons
//
//  Created by ShannonChen on 2016/11/27.
//  Copyright © 2016年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end

@implementation ViewController

- (void)addStretchableImage:(UIImage *)image
          withContentCenter:(CGRect)rect
                    toLayer:(CALayer *)layer {
    //set image
    layer.contents = (__bridge id)image.CGImage;
    
    //set contentsCenter
    layer.contentsCenter = rect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //load button image
    UIImage *image = [UIImage imageNamed:@"Button.png"];
    
    //set button 1
    [self addStretchableImage:image
            withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5)
                      toLayer:self.button1.layer];
    
    //set button 2
    [self addStretchableImage:image
            withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5)
                      toLayer:self.button2.layer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
