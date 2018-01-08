//
//  YHWebVideoManager.m
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import "YHWebVideoManager.h"
#import "YHWebVideo.h"

#import "YHWebVideoDownloader.h"
#import "YHVideoCache.h"


@interface YHWebVideoManager ()

@property (strong, nonatomic) NSMutableArray <YHWebVideoCombinedOperation *> *runningOperations;

@end

@implementation YHWebVideoManager


+ (YHWebVideoManager *)sharedManager {
    static YHWebVideoManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _runningOperations = [NSMutableArray array];
    }
    return self;
}

- (id <YHWebVideoOperation>)loadVideoWithURL:(NSURL *)url completion:(YHVideoFetchingCompletion)completion {
    
    if ([url isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    
    if (![url isKindOfClass:[NSURL class]]) {
        url = nil;
        
        
    }
    
    // 1. 判断有没有缓存
    // 2. 如果有缓存，直接返回缓存文件的路径
    // 3. 如果没有缓存
    //   3.1 先下载缓存文件
    //   3.2 下载成功 -> 保存缓存文件 -> 返回结果
    //   3.3 下载失败 -> 删除文件
    
    __block YHWebVideoCombinedOperation *combinedOperation = [YHWebVideoCombinedOperation new];
    __weak YHWebVideoCombinedOperation *weakOperation = combinedOperation;
    
    if (url == nil) {
        dispatch_main_sync_safe(^{
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
            YHNonullBlockCallback(completion, nil, nil, error);
        });
        
        return combinedOperation;
    }
    
    @synchronized (self.runningOperations) {
        [self.runningOperations addObject:combinedOperation];
    }
    
    combinedOperation.cacheOperation = [[YHVideoCache sharedVideoCache] queryDiskCacheForURL:url done:^(NSString *filePath) {
        if (combinedOperation.isCancelled) {
            [self removeRunningOperationSafely:combinedOperation];
            
            return;
        }
        
        // 找到了缓存
        if (filePath.length) {
            
            dispatch_main_sync_safe(^{
                if (!weakOperation.isCancelled) {
                    YHNonullBlockCallback(completion, url, filePath, nil);
                }
            });
            [self removeRunningOperationSafely:combinedOperation];

            
        } else {
            id <YHWebVideoOperation> downloadOperation = [[YHWebVideoDownloader sharedDownloader] downloadVideoWithURL:url completion:^(NSURL *url, NSData *data, NSError *error) {
                
                if (weakOperation.isCancelled) {
                    // Do nothing if the operation was cancelled
                    // if we would call the completedBlock, there could be a race condition between this block and another completedBlock for the same object, so if this one is called second, we will overwrite the new data
                    [self removeRunningOperationSafely:weakOperation];
                    
                } else if (!error && data) {
                    // 下载成功
                    [[YHVideoCache sharedVideoCache] storeVideoDataToDisk:data forURL:url completion:^(NSString *filePath, NSError *error) {
                        
                        if (!weakOperation.isCancelled) {
                            dispatch_main_sync_safe(^{
                                if (filePath.length) {
                                    YHNonullBlockCallback(completion, url, filePath, nil);
                                } else {
                                    YHNonullBlockCallback(completion, url, nil, error);
                                }
                            });
                        }
                        
                        [self removeRunningOperationSafely:weakOperation];
                    }];
                    
                } else {
                    // 下载失败
                    dispatch_main_sync_safe(^{
                        if (!weakOperation.isCancelled) {
                            YHNonullBlockCallback(completion, url, nil, error);
                        }
                    });
                    
                    [self removeRunningOperationSafely:weakOperation];
                }
            }];
            
            // 取消 loading 操作时同时取消下载操作
            combinedOperation.cancelBlock = ^{
                [downloadOperation cancel];
                
                [self removeRunningOperationSafely:weakOperation];
            };
        }
        
    }];
    
    return combinedOperation;
    
}

- (void)removeRunningOperationSafely:(YHWebVideoCombinedOperation *)operation {
    @synchronized (self.runningOperations) {
        [self.runningOperations removeObject:operation];
    }
}

@end
