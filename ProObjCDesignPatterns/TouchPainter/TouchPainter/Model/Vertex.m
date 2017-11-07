//
//  Vertex.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

@synthesize location = _location;
@dynamic size, color;

- (instancetype)initWithLocation:(CGPoint)location {
    
    if (self = [super init]) {
        _location = location;
    }
    
    return self;
}

// 默认属性什么也不做
- (void)setColor:(UIColor *)color {}

- (UIColor *)color {
    return nil;
}

- (void)setSize:(CGFloat)size {}

- (CGFloat)size {
    return 0.0;
}


// Mark 操作什么也不做
- (void)addMark:(id <Mark>)mark {
    
}

- (void)removeMark:(id <Mark>)mark {
    
}

- (id <Mark>)childMarkAtIndex:(NSUInteger)index {
    return nil;
}

- (NSUInteger)count {
    return 0;
}

- (id<Mark>)lastChild {
    return nil;
}


#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {

    Vertex *vertexCopy = [[[self class] allocWithZone:zone] initWithLocation:self.location];
    
    return vertexCopy;
}

@end
