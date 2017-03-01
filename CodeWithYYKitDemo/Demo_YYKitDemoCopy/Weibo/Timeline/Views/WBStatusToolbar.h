//
//  WBStatusToolbar.h
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/18.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "YYKit.h"
#import "WBStatusLayout.h"
@class WBStatusCell;


/**
 *  工具条
 */
@interface WBStatusToolbar : UIView

@property (nonatomic, strong) UIButton *repostButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likeButton;

@property (nonatomic, strong) UIImageView *repostImageView;
@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UIImageView *likeImageView;

@property (nonatomic, strong) YYLabel *repostLabel;
@property (nonatomic, strong) YYLabel *commentLabel;
@property (nonatomic, strong) YYLabel *likeLabel;

@property (nonatomic, strong) CAGradientLayer *line1;
@property (nonatomic, strong) CAGradientLayer *line2;
@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;
@property (nonatomic, weak) WBStatusCell *cell;

- (void)setWithLayout:(WBStatusLayout *)layout;
// set both "liked" and "likeCount"
- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation;

@end
