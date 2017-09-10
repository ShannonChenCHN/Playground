//
//  MyGraphicView.m
//  03-DrawingImages
//
//  Created by ShannonChen on 2016/10/18.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "MyGraphicView.h"
#import "Utilities.h"

@interface MyGraphicView ()

@property (assign, nonatomic) NSInteger index;

@end

@implementation MyGraphicView

- (instancetype)initWithIndex:(NSInteger)index {
    if (self = [super init]) {
        _index = index;
        
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    switch (self.index) {
        case 3:
            [self convertAnImageToGrayscaleInRect:rect];
            break;
            
        case 4: {
            CGSize targetSize = CGSizeMake(250, 250);
            [[self watermarkImageWithTargetSize:targetSize] drawInRect:RectByFittingInRect(SizeMakeRect(targetSize), rect)];
            break;
        }
        default:
            break;
    }
}

//___________________________________  Converting an Image to Grayscale    _____________________________________________________

- (void)convertAnImageToGrayscaleInRect:(CGRect)rect {
    UIImage *sourceImage =  [UIImage imageNamed:@"001"];
    CGRect drawingRect = RectByFittingInRect(SizeMakeRect(sourceImage.size), rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [sourceImage drawInRect:drawingRect];
    
    // Clip the context
    CGContextSaveGState(context);
    CGRect insetRect = RectInsetByPercent(drawingRect, 0.40);
    UIRectClip(insetRect);
    
    // Draw the grayscale version
    [GrayscaleVersionOfImage(sourceImage) drawInRect:drawingRect];
    
    CGContextRestoreGState(context);
    
    // Outline the border between the two versions
    UIRectFrame(insetRect);
}

UIImage *GrayscaleVersionOfImage(UIImage *sourceImage) {
    
    // Establish grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    if (colorSpace == NULL)
    {
        NSLog(@"Error creating grayscale color space");
        return nil;
    }
    
    // Extents are integers
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    // Build context: one byte per pixel, no alpha
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 8, // 8 bits per byte
                                                 width,
                                                 colorSpace,
                                                 (CGBitmapInfo) kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL)
    {
        NSLog(@"Error building grayscale bitmap context");
        return nil;
    }
    
    
    // Replicate image using new color space
    CGRect rect = SizeMakeRect(sourceImage.size);
    CGContextDrawImage(context, rect, sourceImage.CGImage);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Return the grayscale image
    UIImage *output = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    
    return output;
}

//___________________________________  Watermarking an Image    _____________________________________________________

- (UIImage *)watermarkImageWithTargetSize:(CGSize)targetSize {
    
    // Creates a bitmap-based graphics context with the specified options
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
    
    // Get current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Draw the original image into the context
    CGRect targetRect = SizeMakeRect(targetSize);
    UIImage *sourceImage = [UIImage imageNamed:@"001"];
    CGRect imgRect = RectByFittingInRect(SizeMakeRect(sourceImage.size), targetRect);
    [sourceImage drawInRect:imgRect];
    
    // Rotate the context
    CGPoint center = RectGetCenter(targetRect);
    CGContextTranslateCTM(context, center.x, center.y);
    CGContextRotateCTM(context, M_PI_4);
    CGContextTranslateCTM(context, -center.x, -center.y);
    
    // Create a string
    NSString *watermark = @"仅供OnlyU后台审核使用";
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:22];
    CGSize size = [watermark sizeWithAttributes:@{NSFontAttributeName: font}];
    CGRect stringRect = RectCenteredInRect(SizeMakeRect(size), targetRect);
    
    
    // Draw the string, using a blend mode
    CGContextSetBlendMode(context, kCGBlendModeDifference);
    [watermark drawInRect:stringRect withAttributes:@{NSFontAttributeName:font,
                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // Retrieve the new image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
