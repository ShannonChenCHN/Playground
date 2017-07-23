//
//  CustomButton.m
//  ButtonLayoutDemo
//
//  Created by ShannonChen on 2017/7/23.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGSize titleSize = CGSizeMake(contentRect.size.width, 25);
    
    CGRect imageFrame = [self imageRectForContentRect:contentRect];
    
    return CGRectMake((contentRect.size.width - titleSize.width) * 0.5,
                      imageFrame.origin.y + imageFrame.size.height + self.interTitleImageSpacing,
                      titleSize.width,
                      titleSize.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGSize imageSize = CGSizeMake(25, 24);
    
    return CGRectMake((contentRect.size.width - imageSize.width) * 0.5, 0, imageSize.width, imageSize.height);
}


@end
