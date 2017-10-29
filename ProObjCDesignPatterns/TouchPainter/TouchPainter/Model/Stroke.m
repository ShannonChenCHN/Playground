//
//  Stroke.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/29.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "Stroke.h"

@interface Stroke ()

@property (nonatomic, strong) NSMutableArray <id <Mark>> *children;

@end

@implementation Stroke

@dynamic location;

- (instancetype)init {
    self = [super init];
    if (self) {
        _children = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}

- (void)setLocation:(CGPoint)location {
    // do nothing
}

- (CGPoint)location {
    if (self.children.count > 0) {
        return self.children.firstObject.location;
    } else {
        return CGPointZero;
    }
}

- (void)addMark:(id<Mark>)mark {
    [self.children addObject:mark];
}

- (void)removeMark:(id<Mark>)mark {
    if ([self.children containsObject:mark]) {
        // 如果 mark 在这一层，将其移除并返回
        [self.children removeObject:mark];
        
    } else {
        // 否则，让每个子节点去找它
        [self.children makeObjectsPerformSelector:@selector(removeMark:) withObject:mark];
    }
}

- (id<Mark>)childMarkAtIndex:(NSUInteger)index {
    if (index >= self.children.count) {
        return nil;
    } else {
        return self.children[index];
    }
}

- (id<Mark>)lastChild {
    return self.children.lastObject;
}

- (NSUInteger)count {
    return self.children.count;
}

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {

    
    Stroke *strokeCopy = [[[Stroke class] allocWithZone:zone] init];
    
    strokeCopy.color = [UIColor colorWithCGColor:self.color.CGColor];
    
    strokeCopy.size = self.size;
    
    for (id <Mark> child in self.children) {
        id <Mark> childCopy = [child copy];
        [strokeCopy addMark:childCopy];
    }
    
    return strokeCopy;
}


@end
