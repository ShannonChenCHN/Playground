//
//  ClothCanvasView.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ClothCanvasView.h"

@implementation ClothCanvasView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *backgroundImage = [UIImage imageNamed:@"cloth"];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        [self addSubview:backgroundView];
        
        
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

@end
