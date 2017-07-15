//
//  YIDCollectionViewCell.m
//  YIDSlideCollectionView
//
//  Created by ShannonChen on 16/8/15.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "YIDCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface YIDCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation YIDCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, -1.5);
    self.layer.shadowOpacity = 0.15;
    self.layer.shadowRadius = 1.5;
    
    self.blurView.hidden = YES;
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = [imageURL copy];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageURL]];
    
    
}

- (void)setNikeName:(NSString *)nikeName {
    _nikeName = [nikeName copy];
    
    self.nameLabel.text = _nikeName;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        self.layer.shadowOpacity = 0;
    } else {
        self.layer.shadowOpacity = 0.15;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    

    [self bringSubviewToFront:self.cover];
}

@end
