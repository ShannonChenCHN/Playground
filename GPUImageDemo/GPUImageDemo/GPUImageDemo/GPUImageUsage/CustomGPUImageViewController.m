//
//  CustomGPUImageViewController.m
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "CustomGPUImageViewController.h"
#import "SCGPUImage.h"

@interface CustomGPUImageViewController ()

@property (strong, nonatomic) SCGPUImageVideoCamera *videoCamera;
//@property (strong, nonatomic) SCGPUImageOutput<SCGPUImageInput> *filter;

@end

@implementation CustomGPUImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoCamera = [[SCGPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.videoCamera.horizontallyMirrorRearFacingCamera = NO;
    
    SCGPUImageView *imageView = (SCGPUImageView *)self.view;
    imageView.fillMode = kSCGPUImageFillModePreserveAspectRatioAndFill;
    [self.videoCamera addTarget:imageView];
    
    [self.videoCamera startCameraCapture];
}


@end
