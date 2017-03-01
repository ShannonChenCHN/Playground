//
//  SCGPUImageFramebuffer.h
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#else
#import <OpenGL/OpenGL.h>
#import <OpenGL/gl.h>
#endif

#import <QuartzCore/QuartzCore.h>
#import <CoreMedia/CoreMedia.h>

typedef struct SCGPUTextureOptions {
    GLenum minFilter;
    GLenum magFilter;
    GLenum wrapS;
    GLenum wrapT;
    GLenum internalFormat;
    GLenum format;
    GLenum type;
} SCGPUTextureOptions;


@interface SCGPUImageFramebuffer : NSObject {
    BOOL referenceCountingDisabled;
    NSUInteger framebufferReferenceCount;
}

@property(readonly) CGSize size;
@property(readonly) GLuint texture;
@property(readonly) SCGPUTextureOptions textureOptions;
@property(readonly) BOOL missingFramebuffer;

- (id)initWithSize:(CGSize)framebufferSize textureOptions:(SCGPUTextureOptions)fboTextureOptions onlyTexture:(BOOL)onlyGenerateTexture;

// Usage
- (void)activateFramebuffer;

// Reference counting
- (void)lock;
- (void)unlock;
- (void)clearAllLocks;

@end
