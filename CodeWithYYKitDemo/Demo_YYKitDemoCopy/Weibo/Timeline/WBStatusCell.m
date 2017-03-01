//
//  WBStatusCell.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/5.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBStatusView.h"
#import "WBStatusLayout.h"

@implementation WBStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 添加statusView
        [self addStatusView];
    }
    
    return self;
}

- (void)addStatusView {
    
    self.statusView = [WBStatusView new];
    // 传入cell
    _statusView.cell = self;
    _statusView.titleView.cell = self;
    _statusView.profileView.cell = self;
    _statusView.cardView.cell = self;
    _statusView.tagView.cell = self;
    _statusView.toolbar.cell = self;
    
    [self.contentView addSubview:_statusView];
}

- (void)setStatusLayout:(WBStatusLayout *)layout {
    // 设置cell高度
    self.height = layout.cellHeight;
    self.contentView.height = layout.cellHeight;
    
    // 传入layout
    _statusView.layout = layout;
}

// cell 复用时调用
- (void)prepareForReuse {}

@end
