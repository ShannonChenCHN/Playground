//
//  SCSnapshotManager.h
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCSnapshotContent;

NS_ASSUME_NONNULL_BEGIN


/**
 生成长图文快照的回调

 @param snapshot 图文快照，失败则返回 nil
 */
typedef void(^YHSnapshotCompletionHander)(UIImage * _Nullable snapshot);

/**
 长图文分享，根据帖子内容生成长图文
 */
@interface SCSnapshotManager : NSObject

- (void)generateSnapshotWithContent:(SCSnapshotContent *)content completionHander:(nullable YHSnapshotCompletionHander)completionHander;

@end

NS_ASSUME_NONNULL_END
