//
//  WBStatusView.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/17.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "WBStatusView.h"
#import "WBStatusTool.h"

@implementation WBStatusView

- (instancetype)initWithFrame:(CGRect)frame {
    // 设置默认宽高
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 1;
    }

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.exclusiveTouch = YES;   // 点击时不允许同时响应其他view的点击
        @weakify(self);
        
        // 设置contentView
        self.contentView = [UIView new];
        _contentView.width = kScreenWidth;
        _contentView.height = 1;
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        // 添加分割线
#warning static 与 __block
#warning Quartz 2D画图
        static UIImage *topLineBG, *bottomLineBG;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            topLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
                CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
                CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0.8, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
                CGContextAddRect(context, CGRectMake(-2, 3, 4, 4));
                CGContextFillPath(context);
            }];
            bottomLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
                CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
                CGContextSetShadowWithColor(context, CGSizeMake(0, 0.4), 2, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
                CGContextAddRect(context, CGRectMake(-2, -2, 4, 2));
                CGContextFillPath(context);
            }];
        });
        UIImageView *topLine = [[UIImageView alloc] initWithImage:topLineBG];
        topLine.width = _contentView.width;
        topLine.bottom = 0;
        topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [_contentView addSubview:topLine];
        
        
        UIImageView *bottomLine = [[UIImageView alloc] initWithImage:bottomLineBG];
        bottomLine.width = _contentView.width;
        bottomLine.top = _contentView.height;
        bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_contentView addSubview:bottomLine];
        
        // 1. 添加titleView
        _titleView = [WBStatusTitleView new];
        _titleView.hidden = YES;
        [_contentView addSubview:_titleView];
        
        // 2. VIP 自定义背景
        _vipBackgroundView = [UIImageView new];
        _vipBackgroundView.size = CGSizeMake(kScreenWidth, 14.0);
        _vipBackgroundView.top = -2;
        _vipBackgroundView.contentMode = UIViewContentModeTopRight;
        [_contentView addSubview:_vipBackgroundView];
    }
    return self;
}

- (void)setLayout:(WBStatusLayout *)layout {
    layout = layout;
    
    // 计算高度
    self.height = layout.cellHeight;
    _contentView.top = layout.topSpacingHeight;
    _contentView.height = layout.cellHeight - layout.topSpacingHeight - layout.bottomSpacingHeight;
    
    
    CGFloat top = 0;
    // 1. 最顶部的title
    if (layout.titleHeight > 0) {
        _titleView.hidden = NO;
        _titleView.height = layout.titleHeight;
        _titleView.titleLabel.textLayout = layout.titleTextLayout;
        top = layout.titleHeight;
    } else {
        _titleView.hidden = YES;
    }
    
    // 2. VIP 自定义背景
    NSURL *picBg = [WBStatusTool defaultURLForImageURL:layout.status.picBg];
    __weak typeof(_vipBackgroundView) weakVipBackgroundView = _vipBackgroundView; // 防止循环引用
    [_vipBackgroundView setImageWithURL:picBg placeholder:nil options:YYWebImageOptionAvoidSetImage completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        if (image) {
#warning UIImage的缩放
            image = [UIImage imageWithCGImage:image.CGImage scale:2.0 orientation:image.imageOrientation];
            weakVipBackgroundView.image = image;
        }
    }];
}

@end
