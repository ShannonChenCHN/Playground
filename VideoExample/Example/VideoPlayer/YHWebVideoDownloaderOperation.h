//
//  YHWebVideoDownloaderOperation.h
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHWebVideoOperation.h"

typedef void(^YHVideoDownloaderCompletion)(NSURL *url, NSData *data, NSError *error);
typedef void(^YHVideoDownloaderCancelBlock)();


/**
 管理下载任务的 operation 
 */
@interface YHWebVideoDownloaderOperation : NSOperation <YHWebVideoOperation>

- (instancetype)initWithRequest:(NSURLRequest *)request
                      completionBlock:(YHVideoDownloaderCompletion)completionBlock
                      cancelled:(YHVideoDownloaderCancelBlock)cancelBlock;

@end
