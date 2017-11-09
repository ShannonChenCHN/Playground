//
//  SCCustomView.m
//  GradientColorExample
//
//  Created by ShannonChen on 2017/10/24.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCCustomView.h"
#import "UIColor+Gradient.h"


@implementation SCCustomView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.gradientBackgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopLeftToBottomRight
                                                             colors:@[[UIColor colorWithHexString:@"ff4d85"],
                                                                      [UIColor colorWithHexString:@"ff5a5e"]]];
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 1;
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = @"点击屏幕可改变视图大小";
        [label sizeToFit];
        label.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:label];
        
    }
    return self;
}

- (void)setResized:(BOOL)resized {
    
    _resized = resized;
    
    CGPoint center = self.center;
    if (resized) {
        self.frame = CGRectMake(0, 0, 350, 200);
    } else {
        self.frame = CGRectMake(0, 0, 300, 100);
    }
    self.center = center;
    
}

@end
