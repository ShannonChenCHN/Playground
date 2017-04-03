//
//  VideoChatViewController.m
//  VideoChatDemo
//
//  Created by ShannonChen on 2017/1/6.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "VideoChatViewController.h"

#import "MainVideoView.h"
#import "SubVideoView.h"

#import "Macro.h"

#import "IMManager.h"
#import "VideoChatManager.h"
#import "RCDVideoFrameObserver.h"
#import <RongCallLib/RongCallLib.h>
#import <Masonry.h>
#import "MBProgressHUD+Extension.h"
#import <PXAlertView.h>
#import <videoprp/AgoraYuvEnhancerObjc.h>
#import <videoprp/AgoraYuvPreProcessorObjc.h>
#import <videoprp/AgoraVideoSourceObjc.h>
#import <GPUImage.h>
#include "libyuv.h"
#import <AVFoundation/AVFoundation.h>

static NSString * const kYIDUserDefaultIsIdleTimerDisabledKey = @"kYIDUserDefaultIsIdleTimerDisabledKey";

static NSLock *s_lock;

@interface VideoChatViewController () <VideoChatManagerDelegate, RCCallSessionDelegate, YuvPreProcessorProtocol, GPUImageVideoCameraDelegate> {
    uint8 *_videoBuffer;
    int32_t _videoBufferSize;
    CGColorSpaceRef _colorSpace;
}

@property (strong, nonatomic) MainVideoView   *mainVideoView;
@property (strong, nonatomic) SubVideoView    *subVideoView;
@property (strong, nonatomic) UIButton        *closeButton;

@property (strong, nonatomic) UISwitch *filterSwitch;

@property (strong, nonatomic) RCCallSession  *currentSession;
@property (strong, nonatomic) YuvPreProcessor *videoPreProcessor;

@property (strong, nonatomic) GPUImageOutput<GPUImageInput> *filter;

@end

@implementation VideoChatViewController

- (void)dealloc {
    NSLog(@"ksyAgoraClient dealloc");
    if(_videoBuffer)
    {
        free(_videoBuffer);
        _videoBuffer = nil;
    }
    
    s_lock = nil;
    CGColorSpaceRelease(_colorSpace);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _videoBufferSize = 640 * 360 * 4;
        _videoBuffer = (uint8 *)malloc(_videoBufferSize);
        s_lock = [[NSLock alloc] init];
        _colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.filter = [[GPUImageColorInvertFilter alloc] init];
    
    [VideoChatManager sharedManager].delegate = self;
    
    // 禁止自动锁屏
    [[NSUserDefaults standardUserDefaults] setBool:[UIApplication sharedApplication].isIdleTimerDisabled forKey:kYIDUserDefaultIsIdleTimerDisabledKey];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    // 添加 subview

    [self.view addSubview:self.mainVideoView];
    [self.view addSubview:self.subVideoView];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.filterSwitch];
    
    if (self.isCaller) {
        [self startCall];
#warning
//        [MBProgressHUD vc_showActivityIndicatorWithMessage:@"正在连接..." addedTo:self.view];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 恢复锁屏控制
    BOOL isOriginallyIdleTimerDisabled = [[NSUserDefaults standardUserDefaults] boolForKey:kYIDUserDefaultIsIdleTimerDisabledKey];
    [UIApplication sharedApplication].idleTimerDisabled = isOriginallyIdleTimerDisabled;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self.view];
    if ([self.closeButton.layer containsPoint:point]) {
        [self closeButtonSelectedAction];
    }
}

- (void)startCall {
    self.currentSession = [[RCCallClient sharedRCCallClient] startCall:ConversationType_PRIVATE
                                                                 targetId:self.targetId
                                                                       to:@[self.targetId]
                                                                mediaType:RCCallMediaVideo
                                                          sessionDelegate:self
                                                                    extra:nil]; // 拨打
#warning
//    [self.currentSession setVideoView:self.mainVideoView userId:self.targetId];
//    [self.currentSession setVideoView:self.subVideoView userId:self.callerId];
    [self.currentSession setVideoView:self.subVideoView userId:self.targetId];
    [self.currentSession setVideoView:nil userId:self.callerId];

}

#pragma mark - Event Response
- (void)closeButtonSelectedAction {
    
    [[IMManager sharedManager] logout];
    [self.currentSession hangup];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)toggleFilter:(UISwitch *)aSwitch {
//    aSwitch.on ? [self.agoraEnhancer turnOn] : [self.agoraEnhancer turnOff];
    aSwitch.on ? [self.videoPreProcessor turnOn] : [self.videoPreProcessor turnOff];
    
    [MBProgressHUD vc_showMessage:aSwitch.on ? @"美颜已开启" : @"美颜已关闭" addedTo:self.view];
}

#pragma mark - <VideoChatManagerDelegate>
// 接到电话
- (void)videoChatManager:(VideoChatManager *)manager didReceiveCall:(RCCallSession *)callSession {
    self.currentSession = callSession;
    
    [self.currentSession setDelegate:self];
    [self.currentSession accept:RCCallMediaVideo];
    [self.currentSession setVideoView:self.mainVideoView userId:self.targetId];
    [self.currentSession setVideoView:self.subVideoView userId:self.callerId];

}

#pragma mark - <RCCallSessionDelegate>

/// 正在呼叫
- (void)remoteUserDidRing:(NSString *)userId {
    [MBProgressHUD vc_showActivityIndicatorWithMessage:@"正在呼叫..." addedTo:self.view];
}


/// 通话已接通
- (void)callDidConnect {
    [MBProgressHUD vc_hideHUDForView:self.view];
    [PXAlertView showAlertWithTitle:@"提示" message:@"通话已接通"];
    
}

/// 对端用户加入了通话
- (void)remoteUserDidJoin:(NSString *)userId
                mediaType:(RCCallMediaType)mediaType {
    [PXAlertView showAlertWithTitle:@"提示" message:@"对端用户加入了通话"];
}

/// 通话已结束
- (void)callDidDisconnect {
    [MBProgressHUD vc_hideHUDForView:self.view];
    [PXAlertView showAlertWithTitle:@"提示" message:@"通话已结束"];
    
}

/// 对方挂断，有可能是对方网络问题，也有可能是对方手动断开
- (void)remoteUserDidLeft:(NSString *)userId reason:(RCCallDisconnectReason)reason {
    
}

- (void)shouldRingForIncomingCall {
    
}


- (void)remoteUserDidInvite:(NSString *)userId
                  mediaType:(RCCallMediaType)mediaType {
    
}


/// 对端用户切换了媒体类型
- (void)remoteUserDidChangeMediaType:(NSString *)userId
                           mediaType:(RCCallMediaType)mediaType {
    
}

/// 对端用户开启或管理了摄像头的状态
- (void)remoteUserDidDisableCamera:(BOOL)disabled byUser:(NSString *)userId {
    
    
}

- (void)shouldAlertForWaitingRemoteResponse {
    
}


- (void)shouldStopAlertAndRing {
    
}


- (void)errorDidOccur:(RCCallErrorCode)error {
    
}

#pragma mark - <YuvPreProcessorProtocol>
// modify this frame in this callback
- (void)onFrameAvailable:(unsigned char *)y ubuf:(unsigned char *)u vbuf:(unsigned char *)v ystride:(int)ystride ustride:(int)ustride vstride:(int)vstride width:(int)width height:(int)height {
    
    [s_lock lock];
    
    // I420 转 ARGB
    libyuv::I420ToARGB(y, ystride, u, ustride, v, vstride, _videoBuffer, width * 4, width, height);
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, _videoBuffer, _videoBufferSize, NULL);
    CGImage *image = CGImageCreate(width, height, 8, 32, 4 * width, _colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaLast, dataProvider, NULL, NO, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
//    GPUImagePicture *picture = [[GPUImagePicture alloc] initWithCGImage:image];
    
    
    
//    [picture addTarget:self.filter];
    
//    [picture useNextFrameForImageCapture];
//    [picture processImage];
    
    UIImage *processedImage = [self.filter imageByFilteringImage:[UIImage imageWithCGImage:image]];
    CGDataProviderRef provider = CGImageGetDataProvider(processedImage.CGImage);
    CFDataRef bitmapData = CGDataProviderCopyData(provider);
    CGDataProviderRelease(provider);
    const uint8 *data = CFDataGetBytePtr(bitmapData);
    
    libyuv::ARGBToI420(data, width * 4, y, ystride, u, ustride, v, vstride, width, height);
    
    [s_lock unlock];
}

#pragma mark - Getter 

- (MainVideoView *)mainVideoView {
    if (!_mainVideoView) {
        _mainVideoView = [[MainVideoView alloc] initWithFrame:self.view.bounds];
        _mainVideoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _mainVideoView;
}

- (SubVideoView *)subVideoView {
    if (!_subVideoView) {
        CGFloat subVideoWidth = 92;
        CGFloat subVideoHeight = 167;
        
        _subVideoView = [[SubVideoView alloc] initWithFrame:CGRectMake(kScreenWidth - subVideoWidth - 15, 90, subVideoWidth, subVideoHeight)];
    }
    return _subVideoView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        CGFloat closeButtonWH = 50;
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - closeButtonWH - 15, 30, closeButtonWH, closeButtonWH)];
        [_closeButton setImage:[UIImage imageNamed:@"videoChat_close"] forState:UIControlStateNormal];
        _closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _closeButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [_closeButton addTarget:self action:@selector(closeButtonSelectedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UISwitch *)filterSwitch {
    if (!_filterSwitch) {
        _filterSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [_filterSwitch addTarget:self action:@selector(toggleFilter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filterSwitch;
}

- (YuvPreProcessor *)videoPreProcessor {
    if (!_videoPreProcessor) {
        _videoPreProcessor = [[YuvPreProcessor alloc] init];
        _videoPreProcessor.delegate = self;
    }
    return _videoPreProcessor;
}


@end
