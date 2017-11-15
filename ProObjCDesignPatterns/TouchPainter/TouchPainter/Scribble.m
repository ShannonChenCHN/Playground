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
    
@property (nonatomic, strong) id <Mark> mark;
@property (nonatomic, strong) id <Mark> parentMark;
    
@end

@implementation Scribble

- (instancetype)init {
    self = [super init];
    if (self) {
        _parentMark = [[Stroke alloc] init];
    }
    return self;
}
    
#pragma mark - Methods for Mark management
- (void)addMark:(id<Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark {
    // 手动调用 KVO
    [self willChangeValueForKey:NSStringFromSelector(@selector(mark))];
    
    if (shouldAddToPreviousMark) {
        [self.parentMark.lastChild addMark:aMark];
    } else {
        [self.parentMark addMark:aMark];
    }
    
    // 手动调用 KVO
    [self didChangeValueForKey:NSStringFromSelector(@selector(mark))];
}
    
- (void)removeMark:(id<Mark>)aMark {
    
    if (aMark == self.parentMark) {
        return;
    }
    
    
    [self willChangeValueForKey:NSStringFromSelector(@selector(mark))];
    
    [self.parentMark removeMark:aMark];
    
    [self didChangeValueForKey:NSStringFromSelector(@selector(mark))];
}
    
@end
