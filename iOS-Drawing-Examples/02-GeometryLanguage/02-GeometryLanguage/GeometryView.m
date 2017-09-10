//
//  GeometryView.m
//  02-GeometryLanguage
//
//  Created by ShannonChen on 2016/10/12.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "GeometryView.h"

@interface GeometryView ()

@property (assign, nonatomic) NSInteger index;

@end

@implementation GeometryView

- (instancetype)initWithIndex:(NSInteger)index {
    if (self = [super init]) {
        _index = index;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    switch (self.index) {
        case 0:
        [self createASeriesOfRectangleDivisions];
            break;
        case 1:
         [self centerAString];
            break;
        case 2:
            [self drawImageInCenterMode];
            break;
        case 3:
            [self drawImageInAspectFitMode];
            break;
        case 4:
            [self drawImageInAspectFillMode];
            break;
        case 5:
            [self drawImageInScaleToFillMode];
            break;
            
        default:
            break;
    }
    
}


- (void)createASeriesOfRectangleDivisions {
    
    CGRect rect = CGRectMake(100, 100, 200, 200);
    
    UIBezierPath *path;
    CGRect remainder;
    CGRect slice;
    
    // Slice a section off the left and color it orange
    CGRectDivide(rect, &slice, &remainder, 80, CGRectMinXEdge);
    [[UIColor orangeColor] set];
    path = [UIBezierPath bezierPathWithRect:slice];
    [path fill];
    
    
    // Slice the other portion in half horizontally
    rect = remainder;
    CGRectDivide(rect, &slice, &remainder, remainder.size.height / 2, CGRectMinYEdge);
    
    // Tint the sliced portion purple
    [[UIColor purpleColor] set];
    path = [UIBezierPath bezierPathWithRect:slice];
    [path fill];
    
    // Slice a 20-point segment from the bottom left.
    // Draw it in gray
    rect = remainder;
    CGRectDivide(rect, &slice, &remainder, 20, CGRectMinXEdge);
    [[UIColor grayColor] set];
    path = [UIBezierPath bezierPathWithRect:slice];
    [path fill];
    
    // And another 20-point segment from the bottom right.
    // Draw it in gray
    rect = remainder;
    CGRectDivide(rect, &slice, &remainder, 20, CGRectMaxXEdge);
    // Use same color on the right
    path = [UIBezierPath bezierPathWithRect:slice];
    [path fill];
    
    // Fill the rest in brown
    [[UIColor brownColor] set];
    path = [UIBezierPath bezierPathWithRect:remainder];
    [path fill];
    
}

- (void)centerAString {
    
    // Draw gray rectangle
    CGRect grayRectangle = CGRectMake(50, 100, 300, 100);
    [[UIColor grayColor] set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:grayRectangle];
    [path fill];
    
    NSString *string = @"Hello World";
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:48];
    
    // Calculate string size
    CGSize stringSize = [string sizeWithAttributes:@{NSFontAttributeName : font}];
    
    
    // Find the target rectangle
    CGRect target = RectAroundCenter(RectGetCenter(grayRectangle), stringSize);
    
    // Draw the string
    [string drawInRect:target withAttributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : [UIColor greenColor]}];
    
}

- (void)drawImageInCenterMode {
    // Draw gray rectangle
    CGRect grayRectangle = CGRectMake(50, 100, 300, 100);
    [[UIColor grayColor] set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:grayRectangle];
    [path fill];
    
    UIImage *image = [UIImage imageNamed:@"iTunesArtwork"];
    CGSize sourceSize = image.size;
    [image drawInRect:RectCenteredInRect(RectMakeRect(CGPointZero, sourceSize), grayRectangle)];
}

- (void)drawImageInAspectFitMode {
    // Draw gray rectangle
    CGRect grayRectangle = CGRectMake(50, 100, 300, 100);
    [[UIColor grayColor] set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:grayRectangle];
    [path fill];
    
    UIImage *image = [UIImage imageNamed:@"iTunesArtwork"];
    CGSize sourceSize = image.size;
    [image drawInRect:RectByFittingInRect(RectMakeRect(CGPointMake(0, 0), sourceSize), grayRectangle)];
}

- (void)drawImageInAspectFillMode {
    // Draw gray rectangle
    CGRect grayRectangle = CGRectMake(50, 100, 300, 100);
    [[UIColor grayColor] set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:grayRectangle];
    [path fill];
    
    UIImage *image = [UIImage imageNamed:@"iTunesArtwork"];
    CGSize sourceSize = image.size;
    [image drawInRect:RectByFillingRect(RectMakeRect(CGPointZero, sourceSize), grayRectangle)];
}

- (void)drawImageInScaleToFillMode {
    // Draw gray rectangle
    CGRect grayRectangle = CGRectMake(50, 100, 300, 100);
    [[UIColor grayColor] set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:grayRectangle];
    [path fill];
    
    UIImage *image = [UIImage imageNamed:@"iTunesArtwork"];
    [image drawInRect:grayRectangle];
}

//________________________ Rectangle Utilities ____________________________________

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

@end
