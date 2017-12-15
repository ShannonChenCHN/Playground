//
//  YHVideoPlayerManager.h
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 本地视频播放器，播放效果同 gif 动图
 */
@interface YHVideoPlayer : NSObject

@property (nonatomic, assign, readonly) BOOL isPlaying;

- (void)playWithFilePath:(NSString *)path onContainerView:(UIView *)containerView readyToPlay:(void(^)())readyToPlay;

- (void)play;
- (void)pause;
- (void)reset;

/// 更新播放尺寸大小
- (void)layoutPlayerLayerWithSize:(CGSize)size;

@end
