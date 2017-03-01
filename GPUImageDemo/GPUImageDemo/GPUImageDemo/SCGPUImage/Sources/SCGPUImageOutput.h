//
//  SCGPUImageOutput.h
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGPUImageContext.h"
#import "SCGPUImageFramebuffer.h"

dispatch_queue_attr_t GPUImageDefaultQueueAttribute(void);
void runSynchronouslyOnVideoProcessingQueue(void (^block)(void));
void runAsynchronouslyOnVideoProcessingQueue(void (^block)(void));



@interface SCGPUImageOutput : NSObject {
    SCGPUImageFramebuffer *outputFramebuffer;

    NSMutableArray *targets, *targetTextureIndices;
    
    BOOL allTargetsWantMonochromeData;
    BOOL usingNextFrameForImageCapture;

    CGSize inputTextureSize, cachedMaximumOutputSize, forcedMaximumSize;
    
}

@property(nonatomic) BOOL enabled;
@property(readwrite, nonatomic) SCGPUTextureOptions outputTextureOptions;
@property(readwrite, nonatomic, unsafe_unretained) id<SCGPUImageInput> targetToIgnoreForUpdates;


/** Adds a target to receive notifications when new frames are available.
 
 The target will be asked for its next available texture.
 
 See [GPUImageInput newFrameReadyAtTime:]
 
 @param newTarget Target to be added
 */
- (void)addTarget:(id<SCGPUImageInput>)newTarget;


@end
