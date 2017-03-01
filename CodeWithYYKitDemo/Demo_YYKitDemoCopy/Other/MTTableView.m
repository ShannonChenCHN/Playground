//
//  MTTableView.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/4.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "MTTableView.h"

@implementation MTTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delaysContentTouches = NO;  // UIScrollView的作用原理，实现scrollView中touch事件作用子视图http://blog.csdn.net/onlyou930/article/details/8198862
        self.canCancelContentTouches = YES; // scroll view 原理 http://blog.csdn.net/diyagoanyhacker/article/details/6062498
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // Remove touch delay (since iOS 8)
        UIView *wrapView = self.subviews.firstObject;
        // UITableViewWrapperView
        if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
            for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
                // UIScrollViewDelayedTouchesBeganGestureRecognizer
                if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
                    gesture.enabled = NO;
                    break;
                }
            }
        }
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
