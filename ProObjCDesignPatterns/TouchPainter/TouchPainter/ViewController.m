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

#import "PaletteViewController.h"

#import "CoordinatingController.h"

@interface ViewController ()

@property (nonatomic, strong) CanvasView *canvasView;


@end

@implementation ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _strokeColor = [UIColor blackColor];
        
        
        
    }
    return self;
}

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
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectDeleteButton)];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectSaveButton)];
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"打开" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectOpenButton)];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectSettingButton)];
    UIBarButtonItem *undoItem = [[UIBarButtonItem alloc] initWithTitle:@"撤销" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectUndoButton)];
    UIBarButtonItem *redoItem = [[UIBarButtonItem alloc] initWithTitle:@"重做" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectRedoButton)];
    UIBarButtonItem *spacingItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    [toolBar setItems:@[deleteItem, spacingItem, saveItem, spacingItem, openItem, spacingItem, settingItem, spacingItem, undoItem, spacingItem, redoItem]];
    
    
    
    
}


- (void)didSelectDeleteButton {
    

    
}

- (void)didSelectSaveButton {
    
}

- (void)didSelectOpenButton {
    
}

- (void)didSelectSettingButton {
    
    NSDictionary *params = self.strokeColor ? @{@"strokeCOlor" : self.strokeColor} : @{};
    [[CoordinatingController sharedInstance] requestViewTransitionWithTarget:CoordinatingTargetPalette
                                                                      params:params];
}

- (void)didSelectUndoButton {
    
}

- (void)didSelectRedoButton {
    
}


    
@end
