//
//  ViewController.m
//  LayerSprites
//
//  Created by ShannonChen on 2016/11/27.
//  Copyright © 2016年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *coneView;
@property (weak, nonatomic) IBOutlet UIView *shipView;
@property (weak, nonatomic) IBOutlet UIView *iglooView;
@property (weak, nonatomic) IBOutlet UIView *anchorView;

@end

@implementation ViewController

- (void)addSpriteImage:(UIImage *)image
       withContentRect:(CGRect)rect
               toLayer:(CALayer *)layer {
    // set image
    layer.contents = (__bridge id)image.CGImage;
    
    // scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    // set contentsRect
    layer.contentsRect = rect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //load sprite sheet
    UIImage *image = [UIImage imageNamed:@"Sprites.png"];
    
    //set igloo sprite
    [self addSpriteImage:image
         withContentRect:CGRectMake(0, 0, 0.5, 0.5)
                 toLayer:self.iglooView.layer];
    
    //set cone sprite
    [self addSpriteImage:image
         withContentRect:CGRectMake(0.5, 0, 0.5, 0.5)
                 toLayer:self.coneView.layer];

    //set anchor sprite
    [self addSpriteImage:image
         withContentRect:CGRectMake(0, 0.5, 0.5, 0.5)
                 toLayer:self.anchorView.layer];
    
    //set spaceship sprite
    [self addSpriteImage:image
         withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5)
                 toLayer:self.shipView.layer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
