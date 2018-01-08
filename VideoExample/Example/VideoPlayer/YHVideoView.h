//
//  UIView+VideoPlayer.h
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHVideoPlayer.h"


extern NSString * const YHVideoViewDidAppearNotification;
extern NSString * const YHVideoViewDidDisappearNotification;

/**
 播放视频的 view
 主要逻辑：
 1.根据 web 链接查找本地缓存
 2.如果有缓存就直接播放
 3.没有缓存就进行下载，下载完成后就将数据缓存起来，并播放缓存中的文件
 4.视频的播放效果类似于 gif 图，自动循环播放
 
 */
@interface YHVideoView : UIView

@property (nonatomic, strong, readonly) YHVideoPlayer *videoPlayer;
@property (nonatomic, strong, readonly) UIImageView *coverImageView;

- (void)playVideoWithURL:(NSURL *)url coverImageURL:(NSURL *)coverURL;

@end

