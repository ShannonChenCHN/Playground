//
//  WBStatusTagView.h
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/22.
//  Copyright © 2016年 Meitun. All rights reserved.
//  

#import "YYKit.h"
#import "WBStatusLayout.h"
@class WBStatusCell;

/**
 *  下方的tag
 */
@interface WBStatusTagView : UIView

@property (nonatomic, weak) WBStatusCell *cell;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YYLabel *label;
@property (nonatomic, strong) UIButton *button;

@end
