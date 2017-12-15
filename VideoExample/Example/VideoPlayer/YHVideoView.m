//
//  UIView+VideoPlayer.m
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import "YHVideoView.h"
#import "YHWebVideoManager.h"
#import "YHWebVideo.h"

NSString * const YHVideoViewDidAppearNotification = @"YHVideoViewDidAppearNotification";
NSString * const YHVideoViewDidDisappearNotification = @"YHVideoViewDidDisappearNotification";


@interface YHVideoView ()

@property (nonatomic, strong, readwrite) YHVideoPlayer *videoPlayer;
@property (nonatomic, strong, readwrite) UIImageView *coverImageView;

@property (nonatomic, strong) YHWebVideoCombinedOperation *loadingOperation;

@property (nonatomic, assign) BOOL isVisible;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation YHVideoView

- (void)dealloc {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _isVisible = YES;
        
        // 封面占位图
        _coverImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _coverImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_coverImageView];
        
        // 播放器
        _videoPlayer = [[YHVideoPlayer alloc] init];
        
        // 注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidAppear:) name:YHVideoViewDidAppearNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidDisappear:) name:YHVideoViewDidDisappearNotification object:nil];
        
        
        // Playback of the AVPlayer is automatically paused when the app is sent to the background.
        // https://developer.apple.com/library/content/qa/qa1668/_index.html
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidBecomeActiveNotification:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.videoPlayer layoutPlayerLayerWithSize:self.bounds.size];
}

- (void)playVideoWithURL:(NSURL *)url coverImageURL:(NSURL *)coverURL {
    
    // 展示封面图
    self.coverImageView.hidden = NO;
//    [self.coverImageView ys_setImageWithURL:coverURL];
    
    
    // 为了防止播放视频的同时进行刷新时出现闪烁，这里做了判断；如果第一次播放失败，下一次还是要重新加载
    if (url != nil && (![url isEqual:_videoURL] || !self.videoPlayer.isPlaying)) {
        
        _videoURL = url;
        
        // 取消正在下载和正在播放的操作
        [self.loadingOperation cancel];
        [self.videoPlayer reset];
        
        // 开始加载
        __weak typeof(self) weakSelf = self;
        self.loadingOperation = [[YHWebVideoManager sharedManager] loadVideoWithURL:url completion:^(NSURL *url, NSString *filePath, NSError *error) {
            if (!weakSelf) {
                return;
            }
            
            __strong typeof(self) strongSelf = weakSelf;
            dispatch_main_sync_safe(^{
                strongSelf.filePath = filePath;
                if (!error && strongSelf.isVisible) { // iOS 10 下不可见时不能直接播放
                    [strongSelf.videoPlayer playWithFilePath:filePath onContainerView:strongSelf readyToPlay:^{
                        strongSelf.coverImageView.hidden = YES;
                    }];
                } else {
                    strongSelf.coverImageView.hidden = NO;
                }
            });
            
        }];
        
    } else {
        self.coverImageView.hidden = self.videoPlayer.isPlaying;
    }
    
}

// appear 时，继续播放视频
- (void)viewDidAppear:(NSNotification *)notification {
//    if (notification.object == self.controller) {
//        self.isVisible = YES;
//        
//        __weak typeof(self) weakSelf = self;
//        [self.videoPlayer playWithFilePath:self.filePath onContainerView:self readyToPlay:^{
//            weakSelf.coverImageView.hidden = YES;
//        }];
//    }
    
}

// disappear 时，暂停视频
- (void)viewDidDisappear:(NSNotification *)notification {
//    if (notification.object == self.controller) {
//        self.isVisible = NO;
//        [self.videoPlayer pause];
//        self.coverImageView.hidden = NO;
//    }
}

- (void)applicationDidEnterBackgroundNotification:(NSNotification *)notification {
    [self.videoPlayer pause];
    self.coverImageView.hidden = NO;
}

- (void)applicationDidBecomeActiveNotification:(NSNotification *)notification {
//    [self.videoPlayer play];
//    self.coverImageView.hidden = YES;
    __weak typeof(self) weakSelf = self;
    [self.videoPlayer playWithFilePath:self.filePath onContainerView:self readyToPlay:^{
        weakSelf.coverImageView.hidden = YES;
    }];
}

@end

