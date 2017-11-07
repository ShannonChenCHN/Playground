//
//  Vertex.h
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/28.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"


/// 顶点，为绘图提供位置信息
@interface Vertex : NSObject <Mark, NSCopying>


@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, strong, readonly) id <Mark> lastChild;


- (instancetype)initWithLocation:(CGPoint)location;

- (void)addMark:(id <Mark>)mark;
- (void)removeMark:(id <Mark>)mark;
- (id <Mark>)childMarkAtIndex:(NSUInteger)index;

@end
