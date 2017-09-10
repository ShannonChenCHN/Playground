//
//  GraphicImageView.m
//  01-EllipseImageDrawing
//
//  Created by ShannonChen on 16/10/5.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "GraphicImageView.h"

@interface GraphicImageView ()

@property (assign, nonatomic) NSInteger index;

@end

@implementation GraphicImageView

- (instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        _index = index;
        if (self.index == 0 || self.index == 1 || self.index == 2) {
            self.image = [self buildImage];
            self.contentMode = UIViewContentModeCenter;
        }
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
}

- (UIImage *)buildImage {
    UIImage *image = [[UIImage alloc] init];
    
    switch (self.index) {
        case 0:
            image = [self drawImageWithinAQuartzContext];
            break;
            
        case 1:
            image = [self drawImageWithinAnUIKitContext];
            break;
            
        case 2:
            image = [self drawImageWithBezierPath];
            break;
        
    }
    
    return image;
}

- (UIImage *)drawImageWithinAQuartzContext {
    
    // Create a color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {
        NSLog(@"Error allocating color space");
        return nil;
    }
    
    // Create the bitmap context. (Note: in new versions of Xcode, you need to cast the alpha setting.)
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 200,
                                                 200,
                                                 8,
                                                 0,
                                                 colorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    // If the context cannot be created, the color space must be freed.
    if (context == NULL) {
        NSLog(@"Error: Context not created!");
        CGColorSpaceRelease(colorSpace );
        return nil;
    }
    
    // Push the context.
    // (This is optional. Read on for an explanation of this.)
    // UIGraphicsPushContext(context);
    
    // Perform drawing here
    CGContextSetLineWidth(context, 4); // Set the line width
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor); // Set the line color
    CGContextStrokeEllipseInRect(context, CGRectMake(20, 20, 100, 100)); // Draw an ellipse
    
    // Balance the context push if used.
    // UIGraphicsPopContext();
    
    // Convert to image
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    
    // Clean up
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    
    return image;
}

- (UIImage *)drawImageWithinAnUIKitContext {
    CGSize targetSize = CGSizeMake(120, 120);
    BOOL isOpaque = NO;
    
    // Establish the image context
    UIGraphicsBeginImageContextWithOptions(targetSize, isOpaque, 0.0);
    
    // Retrieve the current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Perform the drawing
    CGContextSetLineWidth(context, 4);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeEllipseInRect(context, CGRectMake(10, 10, 100, 100));
    
    // Retrieve the drawn image based on the current context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the image context
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)drawImageWithBezierPath {
    // Create two circular shapes
    CGRect rect = CGRectMake(0, 0, 200, 200);
    UIBezierPath *shape1 = [UIBezierPath bezierPathWithOvalInRect:rect];
    rect.origin.x += 100;
    UIBezierPath *shape2 = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    // Creates a bitmap-based graphics context and makes it the current context.
    UIGraphicsBeginImageContext(CGSizeMake(300, 200));
    
    // First draw purple
    [[UIColor purpleColor] setFill];
    [[UIColor greenColor] setStroke];
    [shape1 fill];
    [shape1 stroke];
    
    // Then draw green
    [[[UIColor greenColor] colorWithAlphaComponent:0.5] setFill];
    [[[UIColor purpleColor] colorWithAlphaComponent:0.5] setStroke];
    [shape2 fill];
    [shape2 stroke];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Removes the current bitmap-based graphics context from the top of the stack.
    UIGraphicsEndImageContext();
    
    
    return image;
}

@end
