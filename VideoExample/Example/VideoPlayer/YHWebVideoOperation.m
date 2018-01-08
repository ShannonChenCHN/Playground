//
//  YHWebVideoOperation.c
//  YHOUSE
//
//  Created by ShannonChen on 2017/12/6.
//  Copyright © 2017年 YHouse. All rights reserved.
//

#import "YHWebVideoOperation.h"


@implementation YHWebVideoCombinedOperation

- (void)setCancelBlock:(void (^)())cancelBlock {
    // check if the operation is already cancelled, then we just call the cancelBlock
    if (self.isCancelled) {
        if (cancelBlock) {
            cancelBlock();
        }
        _cancelBlock = nil; // don't forget to nil the cancelBlock, otherwise we will get crashes
    } else {
        _cancelBlock = [cancelBlock copy];
    }
}

- (void)cancel {
    self.cancelled = YES;
    if (self.cacheOperation) {
        [self.cacheOperation cancel];
        self.cacheOperation = nil;
    }
    if (self.cancelBlock) {
        self.cancelBlock();
        
        _cancelBlock = nil;
    }
}

@end
