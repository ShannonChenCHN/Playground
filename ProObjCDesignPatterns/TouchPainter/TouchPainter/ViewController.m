//
//  ViewController.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "CanvasViewGenerator.h"
#import "BrandingFactory.h"


@interface ViewController ()

@property (nonatomic, strong) CanvasView *canvasView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CanvasViewGenerator *defaultGenerator = [[CanvasViewGenerator alloc] initWithStyle:CanvasViewStyleCloth];
    
    self.canvasView = [defaultGenerator canvasViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 436)];
    self.canvasView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.canvasView];
    
    BrandingFactory *factory = [BrandingFactory factoryWithBrand:BrandNameAcme];
    UIView *view = [factory brandedViewWithFrame:CGRectZero];
    UIButton *button = [factory brandedMainButtonWithFrame:CGRectZero];
    
    CGFloat toolBarHeight = 49;
    CGRect frame = CGRectMake(0, self.view.bounds.size.height - toolBarHeight, self.view.bounds.size.width, toolBarHeight);
    UIToolbar *toolBar = [factory brandedToolBarWithFrame:frame];
    toolBar.backgroundColor = [UIColor cyanColor];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:toolBar];
    
}


@end
