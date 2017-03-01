//
//  WBStatusTitleView.h
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/22.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "YYKit.h"
#import "WBStatusLayout.h"
@class WBStatusCell;

/**
 *  最上方的标题栏
 */
@interface WBStatusTitleView : UIView

@property (nonatomic, weak) WBStatusCell *cell;

@property (nonatomic, strong) YYLabel *titleLabel; ///< 标题

@end
