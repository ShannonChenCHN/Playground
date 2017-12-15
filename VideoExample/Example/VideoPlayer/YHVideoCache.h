//
//  YHVideoCache.h
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YHWebVideoQueryCompletedBlock)(NSString *filePath);
typedef void(^YHWebVideoStoreCompletedBlock)(NSString *filePath, NSError *error);


/**
 视频缓存处理
 */
@interface YHVideoCache : NSObject

@property (nonatomic, assign) NSUInteger maxCacheSize;   ///< 缓存最大大小，单位 bytes
@property (nonatomic, assign, readonly) NSUInteger totalCacheSize; ///< 缓存总大小

+ (YHVideoCache *)sharedVideoCache;


- (instancetype)initWithNamespace:(NSString *)ns;

/// 查找缓存
- (NSOperation *)queryDiskCacheForURL:(NSURL *)url done:(YHWebVideoQueryCompletedBlock)doneBlock;

/// 保存缓存文件到磁盘
- (void)storeVideoDataToDisk:(NSData *)data forURL:(NSURL *)url completion:(YHWebVideoStoreCompletedBlock)completion;

/// 清除所有缓存
- (void)clearDisk;
- (void)clearDiskOnCompletion:(void(^)())completion;

@end
