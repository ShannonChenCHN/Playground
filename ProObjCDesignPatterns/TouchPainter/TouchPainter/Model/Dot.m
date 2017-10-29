//
//  Dot.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "Dot.h"

@implementation Dot

@synthesize color = _color, size = _size;

#pragma mark - <NSCoping>
- (id)copyWithZone:(NSZone *)zone {
    Dot *dotCopy = [[[self class] allocWithZone:zone] initWithLocation:self.location];
    
    dotCopy.size = self.size;
    dotCopy.color = [UIColor colorWithCGColor:self.color.CGColor];
    
    
    return dotCopy;
}

@end
