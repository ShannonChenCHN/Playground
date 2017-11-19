//
//  Scribble.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/11/12.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "Scribble.h"
#import "Stroke.h"

@interface Scribble ()
    

    
@end

@implementation Scribble

- (instancetype)init {
    self = [super init];
    if (self) {
        _mark = [[Stroke alloc] init];
    }
    return self;
}
    
#pragma mark - Methods for Mark management
- (void)addMark:(id<Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark {
    // 手动调用 KVO
    [self willChangeValueForKey:NSStringFromSelector(@selector(mark))];
    
    if (shouldAddToPreviousMark) {  // 如果是顶点就拼在后面
        [self.mark.lastChild addMark:aMark];
    } else {
        [self.mark addMark:aMark];  // 如果是点或者线就直接存起来
    }
    
    // 手动调用 KVO
    [self didChangeValueForKey:NSStringFromSelector(@selector(mark))];
}
    
- (void)removeMark:(id<Mark>)aMark {
    
    if (aMark == self.mark) {
        return;
    }
    
    
    [self willChangeValueForKey:NSStringFromSelector(@selector(mark))];
    
    [self.mark removeMark:aMark];
    
    [self didChangeValueForKey:NSStringFromSelector(@selector(mark))];
}
    
@end
