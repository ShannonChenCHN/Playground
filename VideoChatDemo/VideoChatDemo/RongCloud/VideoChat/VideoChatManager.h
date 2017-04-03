//
//  VideoChatManager.h
//  YesIDo
//
//  Created by ShannonChen on 16/9/27.
//  Copyright © 2016年 YHouse. All rights reserved.
//

// 融云官方文档 http://www.rongcloud.cn/docs/ios.html

#import <Foundation/Foundation.h>

@class VideoChatManager, RCCallSession;

@protocol VideoChatManagerDelegate <NSObject>

@optional
- (void)videoChatManager:(VideoChatManager *)manager didReceiveCall:(RCCallSession *)callSession;

@end

@interface VideoChatManager : NSObject

@property (weak, nonatomic) id <VideoChatManagerDelegate> delegate;

+ (instancetype)sharedManager;

// 设置 RCCallClient
- (void)start;

@end
