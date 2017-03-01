//
//  MTTableViewCell.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/17.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "MTTableViewCell.h"

@implementation MTTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:[UIScrollView class]]) {
                ((UIScrollView *)subview).delaysContentTouches = NO; // Remove touch delay in iOS 7
                break;
            }
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
