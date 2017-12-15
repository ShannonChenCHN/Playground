//
//  YHVideoCache.m
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHVideoCache.h"
#import "YHWebVideo.h"

#include <sys/param.h>
#include <sys/mount.h>
#import <CommonCrypto/CommonDigest.h>

static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; // 1 week

@interface YHVideoCache ()

@property (nonatomic, strong) dispatch_queue_t ioQueue; // 所有的文件读写操作都在一个线程
@property (strong, nonatomic) NSString *diskCacheDirPath;

@end

@implementation YHVideoCache {
    NSFileManager *_fileManager;
}


static NSString *kCacheDirName = @"video_square";

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (YHVideoCache *)sharedVideoCache {
    static dispatch_once_t once;
    static YHVideoCache *instance;
    dispatch_once(&once, ^{
        instance = [self new];
        
    });
    return instance;
}

- (instancetype)init {
    return [self initWithNamespace:@"default"];
}

- (instancetype)initWithNamespace:(NSString *)namespace {
    if ((self = [super init])) {
        
        // 创建 IO serial queue，所有的文件读写操作都在一个线程
        _ioQueue = dispatch_queue_create("com.yhouse.YHWebVideoCache", DISPATCH_QUEUE_SERIAL);
        
        // 缓存目录
        NSString *fullNamespace = [@"com.yhouse.YHWebVideoCache." stringByAppendingString:namespace];
        NSArray <NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _diskCacheDirPath = [paths.firstObject stringByAppendingPathComponent:fullNamespace];
        
        dispatch_sync(_ioQueue, ^{
            _fileManager = [NSFileManager new];
        });
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(backgroundCleanDisk)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
    }
    
    return self;
}

#pragma mark - Query and store
/// 查找缓存
- (NSOperation *)queryDiskCacheForURL:(NSURL *)url done:(YHWebVideoQueryCompletedBlock)doneBlock {
    if (!doneBlock) {
        return nil;
    }
    
    if (!url) {
        YHNonullBlockCallback(doneBlock, nil);
        return nil;
    }
    
    
    NSOperation *operation = [NSOperation new];
    dispatch_async(self.ioQueue, ^{
        if (operation.isCancelled) {
            return;
        }
        
        NSString *filePath = [self cachePathForURL:url];
        if (![_fileManager fileExistsAtPath:filePath]) {
            filePath = nil;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            YHNonullBlockCallback(doneBlock, filePath);
        });
        
    });
    
    return operation;
}

/// 保存缓存文件到磁盘
- (void)storeVideoDataToDisk:(NSData *)data forURL:(NSURL *)url completion:(YHWebVideoStoreCompletedBlock)completion {
    if (!data || !url) {
        NSError *error = [NSError errorWithDomain:@"YHWebVideoErrorDomain" code:0 userInfo:@{NSLocalizedDescriptionKey : @"Cache store error!"}];
        YHNonullBlockCallback(completion, nil, error);
        return;
    }
    
    // 异步保存文件
    dispatch_async(self.ioQueue, ^{
        
        NSError *error = nil;
        if (![_fileManager fileExistsAtPath:self.diskCacheDirPath]) {
            [_fileManager createDirectoryAtPath:self.diskCacheDirPath withIntermediateDirectories:YES attributes:nil error:&error];
        }
        
        NSString *filePath = [self cachePathForURL:url];
        [_fileManager createFileAtPath:filePath contents:data attributes:nil];
        
        YHNonullBlockCallback(completion, filePath, error);
    });
    
}

#pragma mark - Clean

/// 执行后台删除缓存操作
- (void)backgroundCleanDisk {
    UIApplication *application = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        // Clean up any unfinished task business by marking where you
        // stopped or ending the task outright.
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    // Start the long-running task and return immediately.
    [self cleanDiskWithCompletionBlock:^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
}


/// 清除所有缓存
- (void)clearDisk {
    [self clearDiskOnCompletion:nil];
}

/// 清除所有缓存
- (void)clearDiskOnCompletion:(void (^)())completion {
    dispatch_async(self.ioQueue, ^{
        [_fileManager removeItemAtPath:self.diskCacheDirPath error:nil];
        [_fileManager createDirectoryAtPath:self.diskCacheDirPath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:NULL];
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}

/// 清理磁盘，删除无效的缓存
- (void)cleanDisk {
    [self cleanDiskWithCompletionBlock:nil];
}

/// 清理磁盘，删除无效的缓存
- (void)cleanDiskWithCompletionBlock:(void (^)())completionBlock {
    dispatch_async(self.ioQueue, ^{
        NSURL *diskCacheURL = [NSURL fileURLWithPath:self.diskCacheDirPath isDirectory:YES];
        NSArray *resourceKeys = @[NSURLIsDirectoryKey, NSURLContentModificationDateKey, NSURLTotalFileAllocatedSizeKey];
        
        // 获取所有缓存文件的信息
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtURL:diskCacheURL
                                                   includingPropertiesForKeys:resourceKeys
                                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                 errorHandler:NULL];
        
        NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-kDefaultCacheMaxCacheAge];
        NSMutableDictionary *cacheFiles = [NSMutableDictionary dictionary];
        NSUInteger currentCacheSize = 0;
        

        // 1. 移除过期的文件
        // 2. 保存未过期文件的信息
        NSMutableArray *urlsToDelete = [[NSMutableArray alloc] init];
        for (NSURL *fileURL in fileEnumerator) {
            NSDictionary *resourceValues = [fileURL resourceValuesForKeys:resourceKeys error:NULL];
            
            // 跳过文件夹
            if ([resourceValues[NSURLIsDirectoryKey] boolValue]) {
                continue;
            }
            
            // 保存要删除的过期文件的 url
            NSDate *modificationDate = resourceValues[NSURLContentModificationDateKey];
            if ([[modificationDate laterDate:expirationDate] isEqualToDate:expirationDate]) {
                [urlsToDelete addObject:fileURL];
                continue;
            }
            
            // 计算未过期文件的总大小
            NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
            currentCacheSize += [totalAllocatedSize unsignedIntegerValue];
            [cacheFiles setObject:resourceValues forKey:fileURL];
        }
        
        for (NSURL *fileURL in urlsToDelete) {
            [_fileManager removeItemAtURL:fileURL error:nil];
        }
        
        // 当缓存总体积超标时，优先删除更早的文件
        if (self.maxCacheSize > 0 && currentCacheSize > self.maxCacheSize) {
            // 删除的目标大小是最大体积限制的一般
            const NSUInteger desiredCacheSize = self.maxCacheSize / 2;
            
            // 对缓存文件按照最近修改时间排序（从早到晚）
            NSArray *sortedFiles = [cacheFiles keysSortedByValueWithOptions:NSSortConcurrent
                                                            usingComparator:^NSComparisonResult(id obj1, id obj2) {
                                                                return [obj1[NSURLContentModificationDateKey] compare:obj2[NSURLContentModificationDateKey]];
                                                            }];
            
            // 删除文件直到达到目标
            for (NSURL *fileURL in sortedFiles) {
                if ([_fileManager removeItemAtURL:fileURL error:nil]) {
                    NSDictionary *resourceValues = cacheFiles[fileURL];
                    NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
                    currentCacheSize -= [totalAllocatedSize unsignedIntegerValue];
                    
                    if (currentCacheSize < desiredCacheSize) {
                        break;
                    }
                }
            }
        }
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock();
            });
        }
    });
}

#pragma mark - Cache size

- (NSUInteger)totalCacheSize {
    __block NSUInteger size = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:self.diskCacheDirPath];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [self.diskCacheDirPath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    });
    return size;
}

#pragma mark - Private

- (NSString *)cachePathForKey:(NSString *)key {
    // 文件名
    NSString *fileName = [self cachedFileNameForKey:key];
    
    // 完整路径
    NSString *filePath = [self.diskCacheDirPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

- (NSString *)cachePathForURL:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    
    return [self cachePathForKey:key];
}

- (NSString *)cachedFileNameForKey:(NSString *)key {
    
    const char *str = key.UTF8String;
    if (str == NULL) str = "";
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *pathExtension = key.pathExtension.length > 0 ? [NSString stringWithFormat:@".%@", key.pathExtension] : @".mp4";
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15]];
    return [NSString stringWithFormat:@"%@%@", filename, pathExtension];
}

- (NSString *)cacheKeyForURL:(NSURL *)url {
    if (url) {
        return url.absoluteString;
    }
    
    return @"";
}


@end
