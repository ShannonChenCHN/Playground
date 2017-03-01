//
//  WBStatusTitleView.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/22.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "WBStatusTitleView.h"

@implementation WBStatusTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    // 设置默认frame值
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellTitleHeight;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        // 添加文字label
        self.titleLabel = [YYLabel new];
        _titleLabel.size = CGSizeMake(kScreenWidth - 100, self.height);
        _titleLabel.left = kWBCellPadding;
        _titleLabel.displaysAsynchronously = YES;  // 异步绘制
        _titleLabel.ignoreCommonProperties = YES;
        _titleLabel.fadeOnHighlight = NO;
        _titleLabel.fadeOnAsynchronouslyDisplay = NO;
        [self addSubview:_titleLabel];
        
        // 添加分割线
#warning 像素转成点
        CALayer *line = [CALayer layer];
        line.size = CGSizeMake(self.width, CGFloatFromPixel(1));
        line.bottom = self.height;
        line.backgroundColor = kWBCellLineColor.CGColor;
        [self.layer addSublayer:line];
        self.exclusiveTouch = YES;
    }
    return self;
}

@end
