//
//  YHWebVideoDownloaderOperation.m
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import "YHWebVideoDownloaderOperation.h"
#import "YHWebVideo.h"

@interface YHWebVideoDownloaderOperation ()

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSURLSessionTask *dataTask;
@property (nonatomic, copy) YHVideoDownloaderCompletion completedBlock;
@property (nonatomic, copy) YHVideoDownloaderCancelBlock cancelBlock;

@end

@implementation YHWebVideoDownloaderOperation

- (instancetype)initWithRequest:(NSURLRequest *)request completionBlock:(YHVideoDownloaderCompletion)completionBlock cancelled:(YHVideoDownloaderCancelBlock)cancelBlock {
    
    self = [super init];
    if (self) {
        _request = request;
        _completedBlock = [completionBlock copy];
        _cancelBlock = [cancelBlock copy];
    }
    
    return self;
}

- (void)start {
    
    @synchronized (self) {
        
        if (self.isCancelled) {
            self.completedBlock = nil;
            self.cancelBlock = nil;
            return;
        }
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.timeoutIntervalForRequest = self.request.timeoutInterval;
        
        // We set our param `delegateQueue` to nil, so the session would create a serial operation queue for performing all delegate method calls and completion handler calls.
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
        self.dataTask = [session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            YHNonullBlockCallback(self.completedBlock, self.request.URL, data, error);
        }];
    }
    
    [self.dataTask resume];
}

- (void)cancel {
    [super cancel];
    
    @synchronized (self) {
        YHNonullBlockCallback(self.cancelBlock);
        
        self.completedBlock = nil;
        self.cancelBlock = nil;
    }
}

@end
