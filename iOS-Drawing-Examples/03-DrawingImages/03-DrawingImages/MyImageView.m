//
//  MyImageView.m
//  03-DrawingImages
//
//  Created by ShannonChen on 2016/10/13.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "MyImageView.h"
#import "Utilities.h"

@interface MyImageView ()

@property (assign, nonatomic) NSInteger index;

@end

@implementation MyImageView

- (instancetype)initWithIndex:(NSInteger)index {
    if (self = [super init]) {
        _index = index;
        
        self.contentMode = UIViewContentModeCenter;
        switch (index) {
            case 0:
                self.image = SwatchWithColor([UIColor greenColor], 150);
                break;
                
            case 1:
                self.image = BuildThumbnail([UIImage imageNamed:@"iTunesArtwork"], CGSizeMake(200, 200), YES);
                break;
                
            case 2:{
//                self.image = ExtractRectFromImage([UIImage imageNamed:@"iTunesArtwork"], CGRectMake(0, 0, 200, 200));
                UIImage *image = ExtractRectFromImage([UIImage imageNamed:@"iTunesArtwork"], CGRectMake(0, 0, 200, 200));
                self.image = ExtractSubimageFromRect(image, CGRectMake(0, 0, 200, 200));
                break;
            }
                
            default:
                break;
        }
        
    }
    return self;
}


UIImage *SwatchWithColor(UIColor *color, CGFloat side) {
    // Create image context (using the main screen scale)
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), YES, 0.0);
    
    // Perform drawing
    [color setFill];
    UIRectFill(CGRectMake(0, 0, side, side));
    
    // Retrieve image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

UIImage *BuildThumbnail(UIImage *sourceImage, CGSize targetSize, BOOL useFitting)
{
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
    
    // Establish the output thumbnail rectangle
    CGRect targetRect = SizeMakeRect(targetSize);
    
    // Create the source image’s bounding rectangle
    CGRect naturalRect = (CGRect){.size = sourceImage.size};
    
    // Calculate fitting or filling destination rectangle
    // See Chapter 2 for a discussion on these functions
    CGRect destinationRect = useFitting ? RectByFittingInRect(naturalRect, targetRect) : RectByFillingRect(naturalRect, targetRect);
    
    // Draw the new thumbnail
    [sourceImage drawInRect:destinationRect];
    
    // Retrieve and return the new image
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return thumbnail;
}





//________________________  Extracting Portions of Images  _____________________

UIImage *ExtractRectFromImage(UIImage *sourceImage, CGRect subRect)
{
    // Extract image
    CGImageRef imageRef = CGImageCreateWithImageInRect(sourceImage.CGImage, subRect);
    if (imageRef != NULL) {
        UIImage *output = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef); // Always remember to release CGImage created by yourself
        return output;
    }
    NSLog(@"Error: Unable to extract subimage");
    return nil;
}

// This is a little less flaky
// when moving to and from Retina images
UIImage *ExtractSubimageFromRect(UIImage *sourceImage, CGRect rect) {
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    CGRect destRect = CGRectMake(-rect.origin.x, -rect.origin.y, sourceImage.size.width, sourceImage.size.height);
    [sourceImage drawInRect:destRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


//________________________  Retrieving Image Data  _____________________

NSData *BytesFromRGBImage(UIImage *sourceImage) {
    
    if (!sourceImage) return nil;
    
    // Establish color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        NSLog(@"Error creating RGB color space");
        return nil;
    }
    // Establish context
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGContextRef context = CGBitmapContextCreate(
                                                 NULL, width, height,
                                                 8, // bits per byte
                                                 width * 4, // bytes per row
                                                 colorSpace,
                                                 (CGBitmapInfo) kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace); if (context == NULL)
    {
        NSLog(@"Error creating context");
        return nil; }
    // Draw source into context bytes
    CGRect rect = (CGRect){.size = sourceImage.size}; CGContextDrawImage(context, rect, sourceImage.CGImage);
    // Create NSData from bytes
    NSData *data = [NSData dataWithBytes:CGBitmapContextGetData(context) length:(width * height * 4)]; // bytes per image
    CGContextRelease(context);
    return data;
}

@end
