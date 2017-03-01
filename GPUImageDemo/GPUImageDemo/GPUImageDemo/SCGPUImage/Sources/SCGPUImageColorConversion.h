//
//  SCGPUImageColorConversion.h
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#ifndef SCGPUImageColorConversion_h
#define SCGPUImageColorConversion_h

#import <GLKit/GLKit.h>

extern GLfloat *kColorConversion601;
extern GLfloat *kColorConversion601FullRange;
extern GLfloat *kColorConversion709;
extern NSString *const kSCGPUImageYUVFullRangeConversionForLAFragmentShaderString;
extern NSString *const kSCGPUImageYUVVideoRangeConversionForLAFragmentShaderString;


#endif /* SCGPUImageColorConversion_h */
