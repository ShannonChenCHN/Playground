//
//  ViewController.m
//  04_DrawingTest
//
//  Created by ShannonChen on 2016/11/27.
//  Copyright © 2016年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CALayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //create sublayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.shadowOpacity = 0.5;
    blueLayer.shadowOffset = CGSizeMake(5, 5);
    blueLayer.shadowRadius = 5.0;
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //set controller as layer delegate
    blueLayer.delegate = self;
    
    //ensure that layer backing image uses correct scale
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    
    //add layer to our view
    [self.layerView.layer addSublayer:blueLayer];
    
    //force layer to redraw
    [blueLayer display];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}


@end
