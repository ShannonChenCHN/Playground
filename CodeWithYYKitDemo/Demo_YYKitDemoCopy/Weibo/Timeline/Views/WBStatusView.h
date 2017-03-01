//
//  WBStatusView.h
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/17.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "YYKit.h"
#import "WBStatusTitleView.h"
#import "WBStatusProfileView.h"
#import "WBStatusCardView.h"
#import "WBStatusTagView.h"
#import "WBStatusToolbar.h"


/**
 *  微博状态的容器视图
 */
@interface WBStatusView : UIView

@property (nonatomic, weak) WBStatusCell *cell;                 ///< 父控件cell
@property (nonatomic, strong) WBStatusLayout *layout;           ///< 布局

@property (nonatomic, strong) UIView *contentView;              ///< 容器

@property (nonatomic, strong) WBStatusTitleView *titleView;     ///< 最上方的标题栏
@property (nonatomic, strong) UIImageView *vipBackgroundView;   ///< VIP 自定义背景

@property (nonatomic, strong) WBStatusProfileView *profileView; ///< 用户信息
@property (nonatomic, strong) YYLabel *textLabel;               ///< 文本
@property (nonatomic, strong) NSArray <UIView *> *picViews;     ///< 图片

@property (nonatomic, strong) UIView *retweetBackgroundView;    ///< 转发容器
@property (nonatomic, strong) YYLabel *retweetTextLable;        ///< 转发文本

@property (nonatomic, strong) WBStatusCardView *cardView;       ///< 卡片
@property (nonatomic, strong) WBStatusTagView *tagView;         ///< 下方Tag
@property (nonatomic, strong) WBStatusToolbar *toolbar;         ///< 工具栏
@property (nonatomic, strong) UIButton *menuButton;             ///< 菜单按钮
@property (nonatomic, strong) UIButton *followButton;           ///< 关注按钮

@end
