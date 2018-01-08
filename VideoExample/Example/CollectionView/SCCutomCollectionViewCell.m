//
//  SCCutomCollectionViewCell.m
//  Example
//
//  Created by ShannonChen on 2017/11/17.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCCutomCollectionViewCell.h"
#import "YHVideoView.h"

@interface SCCutomCollectionViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@property (nonatomic, strong) YHVideoView *videoView;

@end

@implementation SCCutomCollectionViewCell

@synthesize cellModel = _cellModel;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
//        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
//        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        _titleLabel.numberOfLines = 1;
//        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
//        _titleLabel.textAlignment = NSTextAlignmentLeft;
//        _titleLabel.textColor = [UIColor blackColor];
//        [self addSubview:_titleLabel];
        
        _videoView = [[YHVideoView alloc] initWithFrame:self.bounds];
        _videoView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_videoView];
    }
    return self;
}

- (void)setCellModel:(SCCollectionViewCellModel *)cellModel {
    _cellModel = cellModel;
    
    
    if ([cellModel.dataModel isKindOfClass:[NSString class]]) {
        self.titleLabel.text = cellModel.dataModel;
        NSString *urlString = (NSString *)cellModel.dataModel;
        [self.videoView playVideoWithURL:[NSURL URLWithString:urlString] coverImageURL:nil];
        self.videoView.hidden = NO;
    } else {
        [self.videoView.videoPlayer pause];
        self.videoView.hidden = YES;
    }
}

@end
