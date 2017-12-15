//
//  YHWebVideoDownloader.h
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHWebVideoDownloaderOperation.h"


/**
 视频下载器
 */
@interface YHWebVideoDownloader : NSObject

+ (YHWebVideoDownloader *)sharedDownloader;

- (id <YHWebVideoOperation>)downloadVideoWithURL:(NSURL *)url completion:(YHVideoDownloaderCompletion)completion;


@end
