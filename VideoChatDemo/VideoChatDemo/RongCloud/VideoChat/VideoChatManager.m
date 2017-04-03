//
//  VideoChatManager.m
//  YesIDo
//
//  Created by ShannonChen on 16/9/27.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "VideoChatManager.h"

#import "ViewController.h"

#import <RongCallLib/RongCallLib.h>
#import <RongCallKit/RongCallKit.h>

@interface VideoChatManager ()  <RCCallReceiveDelegate>

@end

@implementation VideoChatManager

+ (instancetype)sharedManager {
    static VideoChatManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[VideoChatManager alloc] init];
    });
    
    return sharedManager;
}

- (void)start {
    
    [RCCallClient sharedRCCallClient].enableCallSummary = NO;
    [[RCCallClient sharedRCCallClient] setVideoProfile:RC_VIDEO_PROFILE_360P];
    
    [[RCCallClient sharedRCCallClient] setDelegate:self]; // 接听
}


#pragma mark - <RCCallReceiveDelegate>
// 接到电话
- (void)didReceiveCall:(RCCallSession *)callSession {

    if ([self.delegate respondsToSelector:@selector(videoChatManager:didReceiveCall:)]) {
        [self.delegate videoChatManager:self didReceiveCall:callSession];
    }
}

- (void)didReceiveCallRemoteNotification:(NSString *)callId
                           inviterUserId:(NSString *)inviterUserId
                               mediaType:(RCCallMediaType)mediaType
                              userIdList:(NSArray *)userIdList
                                userDict:(NSDictionary *)userDict {
    
}

- (void)didCancelCallRemoteNotification:(NSString *)callId
                          inviterUserId:(NSString *)inviterUserId
                              mediaType:(RCCallMediaType)mediaType
                             userIdList:(NSArray *)userIdList {
    
}

@end
