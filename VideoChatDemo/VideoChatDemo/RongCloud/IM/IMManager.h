//
//  IMManager.h
//  YesIDo
//
//  Created by ShannonChen on 16/9/26.
//  Copyright © 2016年 YHouse. All rights reserved.
//

// 融云官方文档 http://www.rongcloud.cn/docs/ios.html

#import <Foundation/Foundation.h>


typedef void(^IMManagerLoginCompletionHandler)(BOOL success);

@interface IMManager : NSObject

+ (instancetype)sharedManager;

// 初始化设置，在程序启动时调用
- (void)start;

/// 连接融云服务器，前提是已经登录（在程序启动时，如果用户已经登录，就会连接融云服务器；如果未登录 YID 的，就要将连接绑定到登录操作上）
- (void)loginWithRongCloudToken:(NSString *)rongCloudToken completion:(IMManagerLoginCompletionHandler)completion;
- (void)logout;

@end
