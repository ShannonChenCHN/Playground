//
//  UIColor+Gradient.h
//  GradientColorExample
//
//  Created by ShannonChen on 2017/9/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Gradient.h"


@interface UIColor (Hex)

+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string;

@end


@interface UIColor (Gradient)

+ (UIColor * _Nullable)colorWithGradientStyle:(UIGradientStyle)gradientStyle withFrame:(CGRect)frame andColors:(NSArray<UIColor *> * _Nonnull)colors;

@end
