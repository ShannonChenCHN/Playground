//
//  YHVideoPlayerManager.m
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import "YHVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "YHWebVideo.h"

@interface YHVideoPlayer ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayerItem *currentPlayerItem;
@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, copy) void(^readyToPlay)();

@end

@implementation YHVideoPlayer {
    BOOL _hasRegisteredAsObserver;
}


- (void)dealloc {

    [self.currentPlayerItem removeObserver:self forKeyPath:NSStringFromSelector(@selector(status))];
    if (_hasRegisteredAsObserver) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
    [_playerLayer removeFromSuperlayer];
    
    _player = nil;
    _playerLayer = nil;
    _currentPlayerItem = nil;
}


- (void)playWithFilePath:(NSString *)path onContainerView:(UIView *)containerView readyToPlay:(void(^)())readyToPlay {
    if (path == nil ||
        path.length == 0 ||
        containerView == nil) {
            return;
    }
    
    self.readyToPlay = readyToPlay;
    self.containerView = containerView;
    
    // 重新创建新的播放器进行播放
    NSURL *videoPathURL = [NSURL fileURLWithPath:path];
    AVURLAsset *videoURLAsset = [AVURLAsset URLAssetWithURL:videoPathURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:videoURLAsset];
    
    // 监听播放事件
    [self registerObserverForPlayerItem:playerItem];
    
    // 更新 item
    if (self.player) {
        [self.currentPlayerItem removeObserver:self forKeyPath:NSStringFromSelector(@selector(status))];
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
    } else {
        self.player = [AVPlayer playerWithPlayerItem:playerItem];
        self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        self.player.muted = YES;
        
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = containerView.bounds;
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [containerView.layer addSublayer:self.playerLayer];
    }
    
    // 通过 strong 持有 playerItem，防止 playerItem 比作为 observer 的 self 更早销毁造成崩溃
    self.currentPlayerItem = playerItem;
    
    // 开始播放
    [self.player play];
    
}

- (BOOL)isPlaying {
    return self.player.rate != 0;
}

- (void)pause {
    [self.player pause];
}

- (void)play {
    [self.player play];
}

- (void)reset {
    self.readyToPlay = nil;
    [self.player pause];
}

/// 更新播放尺寸大小
- (void)layoutPlayerLayerWithSize:(CGSize)size {
    self.playerLayer.frame = CGRectMake(0, 0, size.width, size.height);
}

/// 监听播放事件
- (void)registerObserverForPlayerItem:(AVPlayerItem *)playerItem {
    // 监听状态
    [playerItem addObserver:self
                 forKeyPath:NSStringFromSelector(@selector(status))
                    options:NSKeyValueObservingOptionNew context:nil];
    
    // 播放结束的事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:playerItem];
    _hasRegisteredAsObserver = YES;
}

#pragma mark - Notification

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.currentPlayerItem) {
        switch (self.player.currentItem.status) {
            case AVPlayerItemStatusUnknown:
                
                break;
            case AVPlayerItemStatusReadyToPlay:
                
                YHNonullBlockCallback(self.readyToPlay);
                break;
            case AVPlayerItemStatusFailed:
                
                break;
                
            default:
                break;
        }
    }
}

// 播放结束后自动重播
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *playerItem = notification.object;
    [playerItem seekToTime:kCMTimeZero];
}


@end
