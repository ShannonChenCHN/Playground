//
//  Scribble.h
//  TouchPainter
//
//  Created by ShannonChen on 2017/11/12.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"


/**
 涂鸦 model
 */
@interface Scribble : NSObject

@property (nonatomic, strong) id <Mark> mark;
    
- (void)addMark:(id <Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark;
- (void)removeMark:(id <Mark>)aMark;

@end
