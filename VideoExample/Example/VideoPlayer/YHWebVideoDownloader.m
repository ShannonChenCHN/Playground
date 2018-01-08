//
//  YHWebVideoDownloader.m
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import "YHWebVideoDownloader.h"


@interface YHWebVideoDownloader ()

@property (nonatomic, strong) NSOperationQueue *downloadQueue;
@property (nonatomic, strong) NSMutableDictionary <NSURL *, NSArray <YHVideoDownloaderCompletion>*> *URLCallbacks;

// This queue is used to serialize the handling of the network responses of all the download operation in a single queue
@property (nonatomic, nullable) dispatch_queue_t barrierQueue;

@end

@implementation YHWebVideoDownloader


+ (YHWebVideoDownloader *)sharedDownloader {
    static YHWebVideoDownloader *downloader = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (downloader == nil) {
            downloader = [[self alloc] init];
        }
    });
    
    return downloader;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _downloadQueue = [[NSOperationQueue alloc] init];
        _downloadQueue.maxConcurrentOperationCount = 2;
        _URLCallbacks = [NSMutableDictionary dictionary];
        _barrierQueue = dispatch_queue_create("com.yhouse.YHWebVideoDownloaderBarrierQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (id <YHWebVideoOperation>)downloadVideoWithURL:(NSURL *)url completion:(YHVideoDownloaderCompletion)completion {
    
    
    // 每个 url 只有一个对应的下载 operation，但是可以有多个不同的回调
    // 1. 判断这个 url 是否已经下载过
    // 2. 如果已经创建过这个 url 的 operation 了，就取出 url 对应的 operation
    // 3. 如果没有就新创建一个 operation，然后再保存起来
    // 4. 最后给这个 url 对应的下载 operation，添加 completion block
    
    __block YHWebVideoDownloaderOperation *operation;
    __weak typeof(self) weakSelf = self;
    
    [self addCompletionBlock:completion forURL:url createCallback:^{
        
        NSTimeInterval timeoutInterval = 15.0;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:(NSURLRequestReloadIgnoringLocalCacheData) timeoutInterval:timeoutInterval];
        request.HTTPShouldUsePipelining = YES;
        
        operation = [[YHWebVideoDownloaderOperation alloc] initWithRequest:request completionBlock:^(NSURL *url, NSData *data, NSError *error) {
            YHWebVideoDownloader *strongSelf = weakSelf;
            if (!strongSelf) return;
            
            NSArray <YHVideoDownloaderCompletion> *callbacksForURL = [strongSelf callbacksForURL:url];
           
            // 移除所有回调
            [strongSelf removeCallbacksForURL:url];
            
            // 执行回调 block
            for (YHVideoDownloaderCompletion completion in callbacksForURL) {
                if (completion) {
                    completion(url, data, error);
                }
            }
        } cancelled:^{
            YHWebVideoDownloader *strongSelf = weakSelf;
            if (!strongSelf) return;
            
            // 移除所有回调
            [strongSelf removeCallbacksForURL:url];
        }];
        
        // 加入到队列，默认优先级时 FIFO
        [weakSelf.downloadQueue addOperation:operation];
        
    }];
    
    return operation;
}

- (void)addCompletionBlock:(YHVideoDownloaderCompletion)completionBlock forURL:(NSURL *)url createCallback:(void(^)())createCallback {
    
    if (url == nil) {
        if (completionBlock != nil) {
            completionBlock(nil, nil, nil);
        }
        return;
    }
    
    dispatch_barrier_sync(self.barrierQueue, ^{
        BOOL firstTime = NO;
        if (!self.URLCallbacks[url]) {
            self.URLCallbacks[url] = [NSMutableArray new];
            firstTime = YES;
        }
        
        // Handle single download of simultaneous download request for the same URL
        NSMutableArray *callbacksForURL = self.URLCallbacks[url];
        if (completionBlock) {
            [callbacksForURL addObject:[completionBlock copy]];
        }
        self.URLCallbacks[url] = callbacksForURL;
        
        // 只有第一次才需要创建 operation
        if (firstTime) {
            createCallback();
        }
        
    });
}

- (void)removeCallbacksForURL:(NSURL *)url {
    dispatch_barrier_async(self.barrierQueue, ^{
        [self.URLCallbacks removeObjectForKey:url];
    });
}

- (NSArray <YHVideoDownloaderCompletion>*)callbacksForURL:(NSURL *)url {
    __block NSArray *callbacksForURL;
    dispatch_sync(self.barrierQueue, ^{
        callbacksForURL = self.URLCallbacks[url];
    });
    return [callbacksForURL copy];
}

@end
