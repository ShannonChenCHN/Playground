//
//  SCSnapshotManager.m
//  SCSnapshotDemo
//
//  Created by ShannonChen on 2017/3/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCSnapshotManager.h"


// Model
#import "SCSnapshotContent.h"

// Components
#import "SCQRCodeGenerator.h"
#import "SCSnapshotImageDownloader.h"
#import "SCSnapshotContentView.h"
#import "SCSnapshotGenerator.h"


static NSUInteger const kSnapshotImageDataLengthMax = 4 * 1024 * 1024; // 最大 4 M
static NSString * const kSnapshotFailureMessage = @"快照生成失败，请重新生成!";


@interface SCSnapshotManager ()

@property (strong, nonatomic) SCSnapshotContent *content;

@end

@implementation SCSnapshotManager

- (void)dealloc {
    
}

#pragma mark - Public methods
- (void)generateSnapshotWithContent:(SCSnapshotContent *)content completionHander:(YHSnapshotCompletionHander)completionHander {
    
    NSAssert(content != nil, @"`content` cannot be nil");
    
    if (content && self.content.shareUrl.length) {
        
        self.content = content;
        
    } else {
        if (completionHander) {
            completionHander(nil);
        }
        return;
    }
    
    
    
    // 1. 生成二维码
    self.content.qrCodeImage = [SCQRCodeGenerator generateQRCodeImageWithString:self.content.shareUrl size:CGSizeMake(POINT_FROM_PIXEL(220), POINT_FROM_PIXEL(220))];
    
    // 2. 下载图片
#if DEBUG
    NSTimeInterval startTime = [NSDate date].timeIntervalSince1970;
#endif
    
    SCSnapshotImageDownloader *imageDownloader = [[SCSnapshotImageDownloader alloc] init];
    [imageDownloader downloadWithAvatarURLString:self.content.posterAvatarURLString
                                 photoURLStrings:self.content.picUrls
                               completionHandler:^(UIImage * _Nullable avatar, NSArray<UIImage *> * _Nullable photos, BOOL success) {
#if DEBUG
                                   NSTimeInterval downloadCompletionTime = [NSDate date].timeIntervalSince1970;
#endif
                                   
                                   
                                   if (!success) {
                                       if (completionHander) {
                                           completionHander(nil);
                                       }

                                   } else {
                                       self.content.posterAvatarImage = avatar;
                                       self.content.downloadedImages = photos;
                                       
                                       // 3. 创建 view、排版内容
                                       SCSnapshotContentView *contentView = [[SCSnapshotContentView alloc] initWithContent:self.content];
                                       
                                       // 4. 生成图片
                                       UIImage *snapshot = [SCSnapshotGenerator generateSnapshotWithView:contentView maxDataLength:kSnapshotImageDataLengthMax];
                                       
#if DEBUG
                                       NSTimeInterval snapshotDoneTime = [NSDate date].timeIntervalSince1970;
                                       NSLog(@"快照下载耗时：%g", downloadCompletionTime - startTime);
                                       NSLog(@"快照生成耗时：%g", snapshotDoneTime - downloadCompletionTime);
#endif
                                       if (completionHander) {
                                           completionHander(snapshot);
                                       }
                                   }
                               }];
    
}

@end
