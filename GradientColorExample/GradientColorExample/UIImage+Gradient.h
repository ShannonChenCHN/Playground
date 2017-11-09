//
//  UIImage+Gradient.h
//  GradientColorExample
//
//  Created by ShannonChen on 2017/9/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSUInteger, UIGradientStyle) {
    /**
     *  Returns a gradual blend between colors originating at the leftmost point of an object's frame, and ending at the rightmost point of the object's frame.
     *
     *  @since 1.0
     */
    UIGradientStyleLeftToRight,
    UIGradientStyleTopLeftToBottomRight,
    /**
     *  Returns a gradual blend between colors originating at the center of an object's frame, and ending at all edges of the object's frame. NOTE: Supports a Maximum of 2 Colors.
     *
     *  @since 1.0
     */
    UIGradientStyleRadial,
    /**
     *  Returns a gradual blend between colors originating at the topmost point of an object's frame, and ending at the bottommost point of the object's frame.
     *
     *  @since 1.0
     */
    UIGradientStyleTopToBottom,
    UIGradientStyleDiagonal
};


@interface UIImage (Gradient)

// reference: Chameleon https://github.com/ViccAlexander/Chameleon/blob/6dd284bde21ea2e7f9fd89bc36f40df16e16369d/Pod/Classes/Objective-C/UIColor%2BChameleon.m#L473
+ (instancetype _Nullable)imageWithGradientStyle:(UIGradientStyle)gradientStyle frame:(CGRect)frame colors:(NSArray<UIColor *> * _Nonnull)colors;

@end
