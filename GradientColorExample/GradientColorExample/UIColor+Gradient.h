//
//  UIColor+Gradient.h
//  GradientColorExample
//
//  Created by ShannonChen on 2017/9/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Gradient.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string;

@end


@interface UIColor (Gradient)

+ (UIColor * _Nullable)colorWithGradientStyle:(UIGradientStyle)gradientStyle frame:(CGRect)frame colors:(NSArray<UIColor *> * _Nonnull)colors;

+ (UIColor * _Nullable)colorWithGradientStyle:(UIGradientStyle)gradientStyle colors:(NSArray<UIColor *> * _Nonnull)colors;


@end

@interface UIView (Gradient)

@property (strong, nonatomic) UIColor *gradientBackgroundColor;

@end


NS_ASSUME_NONNULL_END
