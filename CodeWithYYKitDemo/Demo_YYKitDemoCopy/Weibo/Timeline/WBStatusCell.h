//
//  WBStatusCell.h
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/5.
//  Copyright © 2016年 Meitun. All rights reserved.
//  每条微博状态对应一个cell

#import "MTTableViewCell.h"
@class WBStatusView, WBStatusLayout;

/**
 *  微博状态cell
 */
@interface WBStatusCell : MTTableViewCell

@property (nonatomic, strong) WBStatusView *statusView; ///< 微博状态的容器视图

/**
 *  设置布局对象
 *
 *  @param layout 计算好的cell布局对象
 */
- (void)setStatusLayout:(WBStatusLayout *)layout;

@end
