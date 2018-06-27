//
//  CTMessageListView.m
//  CTMessageListView
//
//  Created by ShannonChen on 2018/6/27.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import "CTMessageListView.h"

@interface CTMessageListView ()

@end

@implementation CTMessageListView

- (void)reloadData {
    
    // 1. 如果复用池中已经有可用的 label 了，就直接复用，设置数据，
    //    如果没有，就添加一个新 label，如果所有数据都展示了，还有剩余的 label，
    //    就隐藏多余的 label
    CGFloat marginTopBottom = 10;
    CGFloat originY = marginTopBottom;
    CGFloat lineSpacing = 5;
    CGFloat labelHeight = 30;
    for (int i = 0; i < self.models.count; i++) {
        BOOL isLastLabel = (i == self.models.count - 1);
        UILabel *label;
        if (i < self.subviews.count) {
            // 如果有现成的 label，就可以直接复用，而不用创建新的 label 了
            label = self.subviews[i];
            label.hidden = NO;
            
            if (isLastLabel && self.models.count < self.subviews.count) {
                // 如果现有的 label 比 model 个数要多，就隐藏多余的 label
                for (int j = i + 1; j < self.subviews.count; j++) {
                    self.subviews[j].hidden = YES;
                }
            }
        } else {
            // 如果没有现成的 label，就需要创建并添加新的 label
            label = [[UILabel alloc] init];
            [self addSubview:label];
        }
        
        label.text = [NSString stringWithFormat:@"• %@", self.models[i]];
        label.frame = CGRectMake(0, originY, self.bounds.size.width, labelHeight);
        
        originY += (labelHeight + (isLastLabel ? 0 : lineSpacing));
        
    }
    
    
    // 2. 计算总体高度，并更新高度
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            originY + marginTopBottom);
    
    
}

@end
