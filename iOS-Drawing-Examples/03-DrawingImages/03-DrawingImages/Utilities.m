//
//  Utilities.m
//  03-DrawingImages
//
//  Created by ShannonChen on 2016/10/18.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "Utilities.h"


//________________________ Rectangle Utilities ____________________________________
CGRect SizeMakeRect(CGSize size) {
    return (CGRect){.origin = CGPointZero, .size = size};
}

CGRect RectMakeRect(CGPoint origin, CGSize size) {
    return (CGRect){.origin = origin, .size = size};
}

CGPoint RectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect RectAroundCenter(CGPoint center, CGSize size) {
    CGFloat halfWidth = size.width / 2.0f;
    CGFloat halfHeight = size.height / 2.0f;
    
    return CGRectMake(center.x - halfWidth, center.y - halfHeight, size.width, size.height);
}

CGRect RectCenteredInRect(CGRect rect, CGRect mainRect) {
    CGFloat dx = CGRectGetMidX(mainRect) - CGRectGetMidX(rect);
    CGFloat dy = CGRectGetMidY(mainRect) - CGRectGetMidY(rect);
    return CGRectOffset(rect, dx, dy);
}


CGRect RectInsetByPercent(CGRect destinationRect, CGFloat insetPercent) {
    CGFloat originX = destinationRect.origin.x + (1 - insetPercent) * destinationRect.size.width / 2;
    CGFloat originY = destinationRect.origin.y + (1 - insetPercent) * destinationRect.size.height / 2;
    CGFloat width = destinationRect.size.width * insetPercent;
    CGFloat height = destinationRect.size.height * insetPercent;
    
    return CGRectMake(originX, originY, width, height);
}

//________________________ Calculating a Destination by Fitting to a Rectangle _____________________

// Multiply the size components by the factor
CGSize SizeScaleByFactor(CGSize aSize, CGFloat factor) {
    return CGSizeMake(aSize.width * factor, aSize.height * factor);
}

// Calculate scale for fitting a size to a destination
CGFloat AspectScaleFit(CGSize sourceSize, CGRect destRect) {
    CGSize destSize = destRect.size;
    CGFloat scaleW = destSize.width / sourceSize.width;
    CGFloat scaleH = destSize.height / sourceSize.height;
    return MIN(scaleW, scaleH);
}

// Return a rect fitting a source to a destination
CGRect RectByFittingInRect(CGRect sourceRect, CGRect destinationRect) {
    CGFloat aspect = AspectScaleFit(sourceRect.size, destinationRect);
    CGSize targetSize = SizeScaleByFactor(sourceRect.size, aspect);
    return RectAroundCenter(RectGetCenter(destinationRect), targetSize);
}

//________________________ Calculating a Destination by Filling a Rectangle _____________________

// Calculate scale for filling a destination
CGFloat AspectScaleFill(CGSize sourceSize, CGRect destRect) {
    CGSize destSize = destRect.size;
    CGFloat scaleW = destSize.width / sourceSize.width;
    CGFloat scaleH = destSize.height / sourceSize.height;
    return MAX(scaleW, scaleH);
}
// Return a rect that fills the destination
CGRect RectByFillingRect(CGRect sourceRect, CGRect destinationRect) {
    CGFloat aspect = AspectScaleFill(sourceRect.size, destinationRect);
    
    CGSize targetSize = SizeScaleByFactor(sourceRect.size, aspect);
    return RectAroundCenter(RectGetCenter(destinationRect), targetSize);
}



