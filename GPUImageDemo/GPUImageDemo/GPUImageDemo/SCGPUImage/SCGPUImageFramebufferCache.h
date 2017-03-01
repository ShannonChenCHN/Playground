//
//  SCGPUImageFramebufferCache.h
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCGPUImageFramebuffer.h"

@interface SCGPUImageFramebufferCache : NSObject

- (void)returnFramebufferToCache:(SCGPUImageFramebuffer *)framebuffer;

- (SCGPUImageFramebuffer *)fetchFramebufferForSize:(CGSize)framebufferSize onlyTexture:(BOOL)onlyTexture;
- (SCGPUImageFramebuffer *)fetchFramebufferForSize:(CGSize)framebufferSize textureOptions:(SCGPUTextureOptions)textureOptions onlyTexture:(BOOL)onlyTexture;

@end
