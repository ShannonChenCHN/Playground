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
#import "Scribble.h"
#import "Stroke.h"
#import "Dot.h"

#import "PaletteViewController.h"

#import "CoordinatingController.h"

@interface ViewController ()

@property (nonatomic, strong) CanvasView *canvasView;
@property (nonatomic, strong) Scribble *scribble;
@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation ViewController


#pragma mark - Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _strokeColor = [UIColor blackColor];
        _strokeSize = 5;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Scribble *scribble = [[Scribble alloc] init];
    self.scribble = scribble;
    
    [self addSubviews];
    
}

- (void)addSubviews {
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


#pragma mark - Setter
- (void)setScribble:(Scribble *)scribble {
    if (scribble != _scribble) {
        
        _scribble = scribble;
        
        [scribble addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(mark))
                      options:NSKeyValueObservingOptionInitial |
                              NSKeyValueObservingOptionNew
                      context:nil];
    }
}

#pragma mark - Action

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


#pragma mark - Touch Event Handlers
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.startPoint = [touches.anyObject locationInView:self.canvasView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint lastPoint = [touches.anyObject previousLocationInView:self.canvasView];
    
    // 如果这是手指的拖动，就像涂鸦添加一个线条
    if (CGPointEqualToPoint(lastPoint, self.startPoint)) {
        id <Mark> newStroke = [[Stroke alloc] init];
        newStroke.color = self.strokeColor;
        newStroke.size = self.strokeSize;
        [self.scribble addMark:newStroke shouldAddToPreviousMark:NO];
    }
    
    // 把当前触摸点作为顶点添加到临时线条
    CGPoint thisPoint = [touches.anyObject locationInView:self.canvasView];
    Vertex *vertex = [[Vertex alloc] initWithLocation:thisPoint];
    [self.scribble addMark:vertex shouldAddToPreviousMark:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint lastPoint = [touches.anyObject previousLocationInView:self.canvasView];
    CGPoint thisPoint = [touches.anyObject locationInView:self.canvasView];
    
    // 如果触摸从未移动，就向现有的 Stroke 组合体添加一个点，否则就将它作为最后一个顶点添加到临时线条
    if (CGPointEqualToPoint(lastPoint, thisPoint)) {
        
        Dot *singleDot = [[Dot alloc] initWithLocation:thisPoint];
        singleDot.color = self.strokeColor;
        singleDot.size = self.strokeSize;
        [self.scribble addMark:singleDot shouldAddToPreviousMark:NO];
    }
    
    // 重置起点
    self.startPoint = CGPointZero;
    
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.startPoint = CGPointZero;
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isKindOfClass:[Scribble class]] && [keyPath isEqualToString:NSStringFromSelector(@selector(mark))]) {
        id <Mark> mark = change[NSKeyValueChangeNewKey];
        self.canvasView.mark = self.scribble.mark;
        [self.canvasView setNeedsDisplay];
    }
}

@end
