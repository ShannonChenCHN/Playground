//
//  CTMessageListView.m
//  CTMessageListView
//
//  Created by ShannonChen on 2018/6/27.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import "CTHotelMessageListView.h"

typedef void(^CellUpdateBlock)(CGRect cellFrame, NSInteger index);


/**
 根据数据更新 cell，计算 view 总高度
 
 @param containerWidth 容器 view 的宽度
 @param padding 内边距
 @param numberOfCells cell 个数
 @param lineSpacing 行间距
 @param interitemSpacing 同一行的 cell 间距
 @param sizeForCellAtIndex 每个 cell 的 size
 @param cellUpdateBlock 更新 cell 的 block
 @return 返回容器 view 的总高度
 */
CGFloat CTHotelMLVUpdateCells(CGFloat containerWidth,
                              UIEdgeInsets padding,
                              NSInteger numberOfCells,
                              CGFloat lineSpacing,
                              CGFloat interitemSpacing,
                              CTHotelMessageListViewCellSizeCallBack sizeForCellAtIndex,
                              CellUpdateBlock cellUpdateBlock) {
    
    CGFloat tmpOriginX = padding.left;
    CGFloat tmpOriginY = padding.top;
    CGFloat maxCellHeightInLine = 0;
    for (NSInteger i = 0; i < numberOfCells; i++) {
        
        // 计算当前 cell 的布局
        CGSize size = sizeForCellAtIndex ? sizeForCellAtIndex(nil, i) : CGSizeZero;
        
        CGFloat rightMost = tmpOriginX + size.width;
        CGFloat boundsRight = containerWidth - padding.right;
        if (rightMost > boundsRight) {
            // 如果当前的内容超出区域范围，则需要换行
            tmpOriginX = padding.left;
            tmpOriginY += (maxCellHeightInLine + lineSpacing);
            maxCellHeightInLine = 0;
        }
        
        CGRect cellFrame = CGRectMake(tmpOriginX, tmpOriginY, size.width, size.height);
        
        // 计算下一个 cell 的布局
        if (size.height > maxCellHeightInLine) maxCellHeightInLine = size.height;
        tmpOriginX += (size.width + interitemSpacing);
        
        // 更新当前 cell 的 frame 和数据
        if (cellUpdateBlock) cellUpdateBlock(cellFrame, i);
    }
    
    CGFloat totalHeight = tmpOriginY + maxCellHeightInLine + padding.bottom;
    
    return totalHeight;
}


CGFloat CTHotelMLVCalculateCellLayouts(CGFloat containerWidth,
                                       UIEdgeInsets padding,
                                       NSInteger numberOfCells,
                                       CGFloat lineSpacing,
                                       CGFloat interitemSpacing,
                                       CTHotelMessageListViewCellSizeCallBack sizeForCellAtIndex) {
    
    return CTHotelMLVUpdateCells(containerWidth, padding, numberOfCells, lineSpacing, interitemSpacing, sizeForCellAtIndex, nil);
    
}

////////////////////////////////////////////////////////////////////////////////

@interface CTHotelMessageListView ()

@property (nonatomic, strong) NSMutableArray <UIView *> *cells;

@end

@implementation CTHotelMessageListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.cells = [NSMutableArray array];
    }
    return self;
}

- (void)reloadData {
    
    CGFloat numberOfCells = _numberOfCellsInListView ? _numberOfCellsInListView(self) : 0;
    
    // 1. 如果复用池中已经有可用的 cell 了，就直接复用，设置数据，
    //    如果没有，就添加一个新 cell，如果所有数据都展示了，还有剩余的 cell，
    //    就隐藏多余的 cell
    CGFloat totalHeight
    = CTHotelMLVUpdateCells(self.bounds.size.width,
                            _padding,
                            numberOfCells,
                            _lineSpacing,
                            _interitemSpacing,
                            ^CGSize(CTHotelMessageListView *listView, NSInteger index) {
                                if (self.sizeForCellAtIndex) {
                                    return self.sizeForCellAtIndex(self, index);
                                } else {
                                    return CGSizeZero;
                                }
                                
                            },
                            ^(CGRect cellFrame, NSInteger index) {
                                [self updateCellAtIndex:index withFrame:cellFrame numberOfCells:numberOfCells];
                                
                            });
    
    // 2. 计算总体高度，并更新高度
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            totalHeight);
    
    
}

- (void)updateCellAtIndex:(NSInteger)index withFrame:(CGRect)cellFrame numberOfCells:(NSInteger)numberOfCells {
    BOOL isLastCell = (index == numberOfCells - 1);
    
    UIView *cell;
    if (index < self.cells.count) {
        // 如果有现成的 cell，就可以直接复用，而不用创建新的 cell 了
        cell = _cells[index];
        cell.hidden = NO;
        
        if (isLastCell && numberOfCells < _cells.count) {
            // 如果现有的 cell 比 model 个数要多，就隐藏多余的 cell
            for (NSInteger j = index + 1; j < _cells.count; j++) {
                _cells[j].hidden = YES;
            }
        }
    } else {
        // 如果没有现成的 cell，就需要创建并添加新的 cell
        if (_createCellIfNeededAtIndex) {
            cell = _createCellIfNeededAtIndex(self, index);
            [self addSubview:cell];
            [_cells addObject:cell];
        } else {
            // do nothing
        }
    }
    
    // 配置数据
    if (_willDisplayCell) {
        _willDisplayCell(self, cell, index);
    }
    
    // 设置 frame
    cell.frame = cellFrame;
}

@end

