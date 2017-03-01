//
//  LiveVideoFilterViewController.m
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "LiveVideoFilterViewController.h"
#import "GPUImage.h"

@interface LiveVideoFilterViewController ()
@property (strong, nonatomic) GPUImageVideoCamera *videoCamera;
@property (strong, nonatomic) GPUImageOutput<GPUImageInput> *filter;

@end

@implementation LiveVideoFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    self.videoCamera.horizontallyMirrorRearFacingCamera = NO;
    
    self.filter = [[GPUImageSepiaFilter alloc] init];
    
    
    [self.filter addTarget:(GPUImageView *)self.view];
    [self.videoCamera addTarget:self.filter];
    
    [self.videoCamera startCameraCapture];
}

- (IBAction)updateSliderValue:(id)sender {
    [(GPUImageSepiaFilter *)self.filter setIntensity:[(UISlider *)sender value]];
}

@end
