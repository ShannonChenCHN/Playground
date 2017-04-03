//
//  IMManager.m
//  YesIDo
//
//  Created by ShannonChen on 16/9/26.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "IMManager.h"

#import <PXAlertView.h>
#import <RongIMKit/RongIMKit.h>

static NSString * const kRongCloudAppKey = @"vnroth0krvjxo";


@interface IMManager () <RCIMConnectionStatusDelegate, RCIMUserInfoDataSource, RCIMReceiveMessageDelegate>

@property (copy, nonatomic) IMManagerLoginCompletionHandler loginCompletionHandler;

@end

@implementation IMManager

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


+ (instancetype)sharedManager {
    static IMManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[IMManager alloc] init];
        // 初始化融云SDK
        [[RCIM sharedRCIM] initWithAppKey:kRongCloudAppKey];
    });
    
    return sharedManager;
}

- (void)start {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification:) name:RCKitDispatchMessageNotification object:nil];
    
    // 注册自定义测试消息
//    [[RCIM sharedRCIM] registerMessageType:[RCDTestMessage class]];
    
    //设置会话列表头像和会话界面头像
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    //开启用户信息和群组信息的持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    
    //设置用户信息源和群组信息源
    [RCIM sharedRCIM].userInfoDataSource = self;
    
    // 是否在发送的所有消息中携带当前登录的用户信息
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    
    //开启发送已读回执
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList = @[@(ConversationType_PRIVATE)];
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    
    
    //设置头像样式
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    
//    [RCIM sharedRCIM].globalNavigationBarTintColor = kNavigationBarTitleColor;
}

- (void)setDeviceToken:(NSString *)deviceToken {
    [[RCIMClient sharedRCIMClient] setDeviceToken:deviceToken];
}

- (void)loginWithRongCloudToken:(NSString *)rongCloudToken completion:(IMManagerLoginCompletionHandler)completion {
    
    self.loginCompletionHandler = completion;
    [self p_loginRongCloudServerWithToken:rongCloudToken];
    
}


- (void)logout {
    [[RCIM sharedRCIM] logout];
}

#pragma mark - Event Response
// 收到通知
- (void)didReceiveMessageNotification:(NSNotification *)notification {
//    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}

#pragma mark - Delegate Methods

#pragma mark - <RCIMConnectionStatusDelegate>
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {  // 被挤下线
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"prompt", nil) message:NSLocalizedString(@"kicked-offline", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button-title.got-it", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:okAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:NULL];
    }
}


#pragma mark - <RCIMUserInfoDataSource>
// 获取聊天用户信息
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion {
    
    
}

#pragma mark - <RCIMReceiveMessageDelegate>
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    
}

#pragma mark - Private Methods 
// 登录融云
- (void)p_loginRongCloudServerWithToken:(NSString *)token {
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {  // 登陆成功
        if (self.loginCompletionHandler) {
            self.loginCompletionHandler(YES);
        }
        
    } error:^(RCConnectErrorCode status) {
        if (self.loginCompletionHandler) {
            self.loginCompletionHandler(NO);
        }
        
    } tokenIncorrect:^{
        if (self.loginCompletionHandler) {
            self.loginCompletionHandler(NO);
        }
        
    }];
}

@end
