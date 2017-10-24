//
//  UIColor+Gradient.m
//  GradientColorExample
//
//  Created by ShannonChen on 2017/9/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "UIColor+Gradient.h"
#import <objc/runtime.h>

@implementation UIColor (Hex)

+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string {
    
    //Color with string and a defualt alpha value of 1.0
    return [self colorWithHexString:string withAlpha:1.0];
}

+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string withAlpha:(CGFloat)alpha {
    
    //Quick return in case string is empty
    if (string.length == 0) {
        return nil;
    }
    
    //Check to see if we need to add a hashtag
    if('#' != [string characterAtIndex:0]) {
        string = [NSString stringWithFormat:@"#%@", string];
    }
    
    //Make sure we have a working string length
    if (string.length != 7 && string.length != 4) {
        
#ifdef DEBUG
        NSLog(@"Unsupported string format: %@", string);
#endif
        
        return nil;
    }
    
    //Check for short hex strings
    if(string.length == 4) {
        
        //Convert to full length hex string
        string = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                  [string substringWithRange:NSMakeRange(1, 1)],[string substringWithRange:NSMakeRange(1, 1)],
                  [string substringWithRange:NSMakeRange(2, 1)],[string substringWithRange:NSMakeRange(2, 1)],
                  [string substringWithRange:NSMakeRange(3, 1)],[string substringWithRange:NSMakeRange(3, 1)]];
    }
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(1, 2)]];
    unsigned red = [[self class] hexValueToUnsigned:redHex];
    
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(3, 2)]];
    unsigned green = [[self class] hexValueToUnsigned:greenHex];
    
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(5, 2)]];
    unsigned blue = [[self class] hexValueToUnsigned:blueHex];
    
    return [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue {
    
    //Define default unsigned value
    unsigned value = 0;
    
    //Scan unsigned value
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    //Return found value
    return value;
}

@end



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIColor (Gradient)

static const char SCGradientStyleKey = '\0';
static const char SCGradientColorsKey = '\0';

- (void)setGradientStyle:(UIGradientStyle)gradientStyle {
    objc_setAssociatedObject(self, &SCGradientStyleKey, @(gradientStyle), OBJC_ASSOCIATION_RETAIN);
}

- (UIGradientStyle)gradientStyle {
    id obj =  objc_getAssociatedObject(self, &SCGradientStyleKey);
    if ([obj respondsToSelector:@selector(integerValue)]) {
        return [obj integerValue];
    }
    
    return UIGradientStyleTopLeftToBottomRight;
}

- (void)setColors:(NSArray<UIColor *> *)colors {
    objc_setAssociatedObject(self, &SCGradientColorsKey, colors, OBJC_ASSOCIATION_RETAIN);
}

- (NSArray<UIColor *> *)colors {
    return objc_getAssociatedObject(self, &SCGradientColorsKey);
}

+ (UIColor *)colorWithGradientStyle:(UIGradientStyle)gradientStyle colors:(NSArray<UIColor *> *)colors {
    UIColor *color = [[UIColor alloc] init];
    color.colors = colors;
    color.gradientStyle = gradientStyle;
    
    return color;
}


+ (UIColor *)colorWithGradientStyle:(UIGradientStyle)gradientStyle frame:(CGRect)frame colors:(NSArray<UIColor *> *)colors {
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageWithGradientStyle:gradientStyle frame:frame colors:colors]];

    return color;
}

@end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIView (Gradient)

static const char SCGradientBackgroundColorKey = '\0';

#pragma mark - Method swizzling
+ (void)load {
    [self exchangeInstanceMethod1:@selector(layoutSubviews) method2:@selector(sc_layoutSubviews)];
}

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}



#pragma mark - color
- (void)setGradientBackgroundColor:(UIColor *)gradientBackgroundColor {
    objc_setAssociatedObject(self, &SCGradientBackgroundColorKey, gradientBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)gradientBackgroundColor {
    return objc_getAssociatedObject(self, &SCGradientBackgroundColorKey);
}


- (void)sc_layoutSubviews {
    [self sc_layoutSubviews];
    
    if (self.gradientBackgroundColor && self.gradientBackgroundColor.colors) {
        self.backgroundColor = [UIColor colorWithGradientStyle:self.gradientBackgroundColor.gradientStyle
                                                         frame:self.bounds
                                                        colors:self.gradientBackgroundColor.colors];
    }
    
}


@end
