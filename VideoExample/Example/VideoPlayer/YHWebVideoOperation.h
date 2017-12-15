//
//  YHWebVideoOperation.h
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/5.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YHWebVideoOperation <NSObject>

- (void)cancel;

@end



/**
 视频加载任务
 */
@interface YHWebVideoCombinedOperation : NSObject <YHWebVideoOperation>

@property (assign, nonatomic, getter = isCancelled) BOOL cancelled;
@property (copy, nonatomic) void (^cancelBlock)();
@property (strong, nonatomic) NSOperation *cacheOperation;

@end


