//
//  GraphicView.m
//  01-EllipseImageDrawing
//
//  Created by ShannonChen on 16/10/5.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "GraphicView.h"

@interface GraphicView ()

@property (assign, nonatomic) NSInteger index;

@end

@implementation GraphicView

- (instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        _index = index;
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    switch (self.index) {
        case 3:
            [self drawAlpabetCircle];
            break;
            
        case 4:
            [self transformContextsDuringDrawing];
            break;
            
        case 5:
            [self preciseTextPlacementAroundACircle];
            break;
            
        case 6:
            [self conflictingLineWidths];
            break;
            
        case 7:
            [self drawDashes];
            break;
            
    }
    
    
}

- (void)drawAlpabetCircle {
    UIFont *font = [UIFont systemFontOfSize:12];
    CGPoint center = CGPointMake(150, 150);
    CGFloat r = 70;
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for(int i = 0; i < 26; i++) {
        NSString *letter = [alphabet substringWithRange:NSMakeRange(i, 1)];
        CGSize letterSize = [letter sizeWithAttributes:@{NSFontAttributeName:font}];
        CGFloat theta = M_PI - i * (2 * M_PI / 26.0);
        CGFloat x = center.x + r * sin(theta) - letterSize.width / 2.0;
        CGFloat y = center.y + r * cos(theta) - letterSize.height / 2.0;
        [letter drawAtPoint:CGPointMake(x, y) withAttributes:@{NSFontAttributeName:font}];
    }
}

- (void)transformContextsDuringDrawing {
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    // Start drawing
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Retrieve the center and set a radius
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat r = center.x * 0.75f;
    
    // Start by adjusting the context origin
    // This affects all subsequent operations
    CGContextTranslateCTM(context, center.x, center.y); // 移到圆心
    
    UIFont *font = [UIFont systemFontOfSize:25];
    
    // Iterate through the alphabet
    for (int i = 0; i < 26; i++) {
        
        // Retrieve the letter and measure its display size
        NSString *letter = [alphabet substringWithRange:NSMakeRange(i, 1)];
        CGSize letterSize = [letter sizeWithAttributes:@{NSFontAttributeName : font}];
        
        // Calculate the current angular offset
        CGFloat theta = i * (2 * M_PI / (float) 26); // 26个字母均分，计算字母所在位置的角度
        
        // Encapsulate each stage of the drawing
        CGContextSaveGState(context);
        
        // Rotate the context
        CGContextRotateCTM(context, theta);  // 旋转
        
        // Translate up to the edge of the radius and move left by
        // half the letter width. The height translation is negative
        // as this drawing sequence uses the UIKit coordinate system.
        // Transformations that move up go to lower y values.
        CGContextTranslateCTM(context, -letterSize.width / 2, -r); // 轴线居中，外移半径
        
        // Draw the letter and pop the transform state
        [letter drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName : font}];
        
        CGContextRestoreGState(context);
    }
}

- (void)preciseTextPlacementAroundACircle {
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    // Start drawing
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Retrieve the center and set a radius
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat r = center.x * 0.75f;
    
    // Start by adjusting the context origin
    // This affects all subsequent operations
    CGContextTranslateCTM(context, center.x, center.y); // 移到圆心
    
    // Calculate the full extent
    UIFont *font = [UIFont systemFontOfSize:25];
    CGFloat fullSize = 0;
    for (int i = 0; i < 26; i++) {
        NSString *letter = [alphabet substringWithRange:NSMakeRange(i, 1)];
        CGSize letterSize = [letter sizeWithAttributes:@{NSFontAttributeName:font}];
        fullSize += letterSize.width;
    }
    
    // Initialize the consumed space
    CGFloat consumedSize = 0.0f;
    
    // Iterate through each letter, consuming that width
    for (int i = 0; i < 26; i++) {
        // Measure each letter
        NSString *letter = [alphabet substringWithRange:NSMakeRange(i, 1)];
        CGSize letterSize = [letter sizeWithAttributes:@{NSFontAttributeName:font}];
        
        // Move the pointer forward, calculating the
        // new percentage of travel along the path
        consumedSize += letterSize.width / 2.0f;
        CGFloat percent = consumedSize / fullSize;  // 算出字体大小真实所占比
        CGFloat theta = percent * 2 * M_PI;
        consumedSize += letterSize.width / 2.0f;
        
        // Prepare to draw the letter by saving the state
        CGContextSaveGState(context);
        
        // Rotate the context by the calculated angle
        CGContextRotateCTM(context, theta);
        
        // Move to the letter position
        CGContextTranslateCTM(context, -letterSize.width / 2, -r);
        
        // Draw the letter
        [letter drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName : font}];
        
        // Reset the context back to the way it was
        CGContextRestoreGState(context);
    }
}

- (void)conflictingLineWidths {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Build a Bezier path and set its width
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 200, 200) cornerRadius:32];
    path.lineWidth = 4;
    
    // Update the context state to use 20-point wide lines
    CGContextSetLineWidth(context, 20);
    
    // Draw this path using the context state
    [[UIColor purpleColor] set];
    
    // Add the path to the current context, and draw the path
    CGContextAddPath(context, path.CGPath);
    CGContextStrokePath(context);
    
    // Draw the path directly through UIKit
    [[UIColor greenColor] set];
    [path stroke];
}

- (void)drawDashes {
    // Get current context
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // Build a Bezier path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 200, 200) cornerRadius:32];
    
    // Set color for the context state
    [[UIColor greenColor] set];
    
    // Set dashes
    CGFloat dashes[] = {10, 5};
    
    // Set the line-stroking pattern for the path.
//    path.lineWidth = 3;
//    [path setLineDash:dashes count:2 phase:5];
//    [path stroke];
    
    CGContextSetLineWidth(currentContext, 3);
    CGContextSetLineDash(currentContext, 5, dashes, 2);
    CGContextAddPath(currentContext, path.CGPath);
    CGContextDrawPath(currentContext, kCGPathStroke);
}

@end
