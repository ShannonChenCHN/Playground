//
//  SCGPUImageContext.h
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCGLProgram.h"
#import "SCGPUImageFramebuffer.h"
#import "SCGPUImageFramebufferCache.h"

#define SCGPUImageRotationSwapsWidthAndHeight(rotation) ((rotation) == kSCGPUImageRotateLeft || (rotation) == kSCGPUImageRotateRight || (rotation) == kSCGPUImageRotateRightFlipVertical || (rotation) == kSCGPUImageRotateRightFlipHorizontal)


typedef NS_ENUM(NSUInteger, SCGPUImageRotationMode) {
    kSCGPUImageNoRotation,
    kSCGPUImageRotateLeft,
    kSCGPUImageRotateRight,
    kSCGPUImageFlipVertical,
    kSCGPUImageFlipHorizonal,
    kSCGPUImageRotateRightFlipVertical,
    kSCGPUImageRotateRightFlipHorizontal,
    kSCGPUImageRotate180
};


@interface SCGPUImageContext : NSObject

@property(readonly, nonatomic) dispatch_queue_t contextQueue;
@property(readwrite, strong, nonatomic) SCGLProgram *currentShaderProgram;
@property(readonly, strong, nonatomic) EAGLContext *context;
@property(readonly) CVOpenGLESTextureCacheRef coreVideoTextureCache;


@property(readonly) SCGPUImageFramebufferCache *framebufferCache;



+ (void *)contextKey;
+ (SCGPUImageContext *)sharedImageProcessingContext;
+ (dispatch_queue_t)sharedContextQueue;
+ (SCGPUImageFramebufferCache *)sharedFramebufferCache;


+ (void)useImageProcessingContext;

+ (void)setActiveShaderProgram:(SCGLProgram *)shaderProgram;

+ (BOOL)deviceSupportsRedTextures;

- (void)presentBufferForDisplay;

- (SCGLProgram *)programForVertexShaderString:(NSString *)vertexShaderString fragmentShaderString:(NSString *)fragmentShaderString;


// Manage fast texture upload
+ (BOOL)supportsFastTextureUpload;


@end


@protocol SCGPUImageInput <NSObject>

- (void)newFrameReadyAtTime:(CMTime)frameTime atIndex:(NSInteger)textureIndex;
- (void)setInputFramebuffer:(SCGPUImageFramebuffer *)newInputFramebuffer atIndex:(NSInteger)textureIndex;
- (NSInteger)nextAvailableTextureIndex;
- (void)setInputSize:(CGSize)newSize atIndex:(NSInteger)textureIndex;
- (void)setInputRotation:(SCGPUImageRotationMode)newInputRotation atIndex:(NSInteger)textureIndex;
- (CGSize)maximumOutputSize;
- (void)endProcessing;
- (BOOL)shouldIgnoreUpdatesToThisTarget;
- (BOOL)enabled;
- (BOOL)wantsMonochromeInput;
- (void)setCurrentlyReceivingMonochromeInput:(BOOL)newValue;


@end
