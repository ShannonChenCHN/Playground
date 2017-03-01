//
//  WBStatusProfileView.h
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/22.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "YYKit.h"
#import "WBStatusLayout.h"
@class WBStatusCell;


/**
 *  用户信息
 */
@interface WBStatusProfileView : UIView

@property (nonatomic, weak) WBStatusCell *cell;
@property (nonatomic, assign) WBUserVerifyType verifyType;  ///< 认证方式

@property (nonatomic, strong) UIImageView *avatarView;      ///< 头像
@property (nonatomic, strong) UIImageView *avatarBadgeView; ///< 头像上的认证徽章
@property (nonatomic, strong) YYLabel *nameLabel;       ///< 昵称
@property (nonatomic, strong) YYLabel *sourceLabel;     ///< 来源


@end
