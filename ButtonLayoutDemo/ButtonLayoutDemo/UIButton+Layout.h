//
//  UIButton+Layout.h
//  ButtonLayoutDemo
//
//  Created by ShannonChen on 2017/7/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCButtonLayoutStyle) {
    SCButtonLayoutStyleImageLeft,
    SCButtonLayoutStyleImageRight,
    SCButtonLayoutStyleImageTop,
    SCButtonLayoutStyleImageBottom,
};

@interface UIButton (Layout)

- (void)sc_setLayoutStyle:(SCButtonLayoutStyle)style spacing:(CGFloat)spacing;

@end
