//
//  CTMessageListView.h
//  CTMessageListView
//
//  Created by ShannonChen on 2018/6/27.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTHotelMessageListView;

typedef NSInteger (^CTHotelMessageListViewCallBack)(CTHotelMessageListView *listView);
typedef __kindof UIView *(^CTHotelMessageListViewCreatViewCallBack)(CTHotelMessageListView *listView, NSInteger index);
typedef void (^CTHotelMessageListViewConfigCellCallBack)(CTHotelMessageListView *listView, __kindof UIView *cell, NSInteger index);
typedef CGSize (^CTHotelMessageListViewCellSizeCallBack)(CTHotelMessageListView *listView, NSInteger index);



/**
 根据数据计算 cell 布局和容器 view 实际总高度
 
 @param containerWidth 容器 view 的宽度
 @param padding 内边距
 @param numberOfCells cell 个数
 @param lineSpacing 行间距
 @param interitemSpacing 同一行的 cell 间距
 @param sizeForCellAtIndex 每个 cell 的 size
 @return 返回容器 view 的总高度
 */
CGFloat CTHotelMLVCalculateCellLayouts(CGFloat containerWidth,
                                       UIEdgeInsets padding,
                                       NSInteger numberOfCells,
                                       CGFloat lineSpacing,
                                       CGFloat interitemSpacing,
                                       CTHotelMessageListViewCellSizeCallBack sizeForCellAtIndex);

/**
 一个轻量的 “collection view”
 
 - “cell” 可以是任意的 UIView 及其子类
 - 只能展示一种样式的 “cell”
 */
@interface CTHotelMessageListView : UIView

@property (nonatomic, assign) UIEdgeInsets padding;     ///< 四周的边距
@property (nonatomic, assign) CGFloat lineSpacing;      ///< 行间距
@property (nonatomic, assign) CGFloat interitemSpacing; ///< cell 间距


@property (nonatomic, copy) CTHotelMessageListViewCallBack numberOfCellsInListView; ///< cell 个数
@property (nonatomic, copy) CTHotelMessageListViewCreatViewCallBack createCellIfNeededAtIndex; ///< 创建 cell 的回调，当没有可复用的 cell 时，就需要创建新的 cell
@property (nonatomic, copy) CTHotelMessageListViewConfigCellCallBack willDisplayCell; ///< 设置 cell 数据（注：不要在这个回调中调整 cell 的位置和大小）
@property (nonatomic, copy) CTHotelMessageListViewCellSizeCallBack sizeForCellAtIndex; ///< cell 的大小

/// 重新加载数据
- (void)reloadData;

@end
