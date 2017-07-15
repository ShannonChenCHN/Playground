//
//  YIDCustomizableButton.m
//  YIDSlideCollectionView
//
//  Created by ShannonChen on 16/8/15.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "YIDCustomizableButton.h"

@interface YIDCustomizableButton()

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat horizontalPadding;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end

@implementation YIDCustomizableButton


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.borderWidth) {
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = self.borderWidth;
    }
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderColor = self.borderColor.CGColor;
    
    
    
}

- (CGSize) intrinsicContentSize {
    CGSize contentSize = [super intrinsicContentSize] ;
    contentSize.width += self.horizontalPadding * 2 ;
    return contentSize ;
}

@end
