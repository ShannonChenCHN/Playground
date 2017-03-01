//
//  StillImageFilterViewController.m
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "StillImageFilterViewController.h"
#import "GPUImage.h"


@interface StillImageFilterViewController ()

@property (strong, nonatomic) GPUImagePicture *sourcePicture;
@property (strong, nonatomic) GPUImageOutput <GPUImageInput> *sepiaFilter;


@end

@implementation StillImageFilterViewController


#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self setupDisplayFiltering];
    
}

- (void)loadView {
    
    // view
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    GPUImageView *primaryView = [[GPUImageView alloc] initWithFrame:screenFrame];
    self.view = primaryView;
    
    // slider
    UISlider *imageSlider = [[UISlider alloc] initWithFrame:CGRectMake(25.0, screenFrame.size.height - 50.0, screenFrame.size.width - 50.0, 40.0)];
    [imageSlider addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
    imageSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    imageSlider.minimumValue = 0.0;
    imageSlider.maximumValue = 1.0;
    imageSlider.value = 0.5;
    [primaryView addSubview:imageSlider];
}

#pragma mark - Event Response
- (void)updateSliderValue:(UISlider *)slider {
    CGFloat midpoint = slider.value;
    [(GPUImageTiltShiftFilter *)self.sepiaFilter setTopFocusLevel:midpoint - 0.1];
    [(GPUImageTiltShiftFilter *)self.sepiaFilter setBottomFocusLevel:midpoint + 0.1];
    
    [self.sourcePicture processImage];
}

#pragma mark - Image Filtering
- (void)setupDisplayFiltering {
    // input image
    UIImage *inputImage = [UIImage imageNamed:@"Lambeau"];
    
    // source picture
    self.sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
    self.sepiaFilter = [[GPUImageTiltShiftFilter alloc] init];
    //    sepiaFilter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
    
    GPUImageView *imageView = (GPUImageView *)self.view;
    [self.sepiaFilter forceProcessingAtSize:imageView.sizeInPixels]; // This is now needed to make the filter run at the smaller output size
    
    [self.sourcePicture addTarget:self.sepiaFilter];
    [self.sepiaFilter addTarget:imageView];
    
    [self.sourcePicture processImage];
    
}

@end
