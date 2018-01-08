//
//  YHWebVideoManager.h
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHWebVideoOperation.h"


typedef void(^YHVideoFetchingCompletion)(NSURL *url, NSString *filePath, NSError *error);


/**
 负责加载视频的 manager
 */
@interface YHWebVideoManager : NSObject

+ (YHWebVideoManager *)sharedManager;

/// 根据 web 链接加载视频，先判断是否有缓存，有缓存则加载缓存，没有缓存就联网下载视频数据，下载完成后先保存缓存，再进行回调
/// 所有的回调都是在主线程执行的
- (id <YHWebVideoOperation>)loadVideoWithURL:(NSURL *)url completion:(YHVideoFetchingCompletion)completion;

@end
