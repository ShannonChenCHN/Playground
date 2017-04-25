//
//  ImageTableViewCell.m
//  DelaySizedImageInTableView
//
//  Created by ShannonChen on 17/4/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.frame = CGRectMake(kLeftRightPadding,
                                      kTopBottomPadding,
                                      self.bounds.size.width - kLeftRightPadding * 2,
                                      self.bounds.size.height - kTopBottomPadding * 2);
}
@end
