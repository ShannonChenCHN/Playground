//
//  SCGPUImageFilter.h
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCGPUImageOutput.h"

#define STRINGIZE(x) #x
#define STRINGIZE2(x) STRINGIZE(x)
#define SHADER_STRING(text) @ STRINGIZE2(text)

extern NSString *const kSCGPUImageVertexShaderString;
extern NSString *const kSCGPUImagePassthroughFragmentShaderString;


@interface SCGPUImageFilter : SCGPUImageOutput

+ (const GLfloat *)textureCoordinatesForRotation:(SCGPUImageRotationMode)rotationMode;

@end
