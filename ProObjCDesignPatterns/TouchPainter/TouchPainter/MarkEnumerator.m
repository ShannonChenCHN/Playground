//
//  MarkEnumerator.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/11/15.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "MarkEnumerator.h"

@interface NSMutableArray<ObjectType> (Stack)

- (void)push:(ObjectType)object;
- (ObjectType)pop;

@end

@implementation NSMutableArray (Stack)

- (void)push:(id)object {
    [self addObject:object];
}

- (id)pop {
    if (self.count == 0) {
        return nil;
    }
    
    id object = self.lastObject;
    
    [self removeLastObject];
    
    return object;
}

@end



@interface MarkEnumerator ()

@property (nonatomic, strong) NSMutableArray *stack;

@end

@implementation MarkEnumerator

- (instancetype)initWithMark:(id<Mark>)mark {
    if (self = [super init]) {
        _stack = [[NSMutableArray alloc] initWithCapacity:mark.count];
        
        [self traverseAndBuildStackWithMark:mark];
    }
    return self;
}

#pragma amrk - Override

- (NSArray *)allObjects {
    // 返回逆序的元素集合
    return [self.stack reverseObjectEnumerator].allObjects;
}

- (id)nextObject {
    return self.stack.pop;
}


#pragma mark - Private

- (void)traverseAndBuildStackWithMark:(id<Mark>)mark {
    if (mark == nil) {
        return;
    }
    
    [self.stack push:mark];
    
    NSUInteger index = mark.count;
    id <Mark> childMark;
    while (childMark = [mark childMarkAtIndex:--index]) {
        [self traverseAndBuildStackWithMark:childMark];
    }
}

@end
