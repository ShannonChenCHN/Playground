//
//  YIDComingFromTopFlowLayout.m
//  YIDSlideCollectionView
//
//  Created by ShannonChen on 16/8/15.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "YIDComingFromTopFlowLayout.h"

@implementation YIDComingFromTopFlowLayout

static const CGFloat kDefaultFirstItemTransform = 0.15f;

//#if 0

- (instancetype)init {
    self = [super init];
    if (self) {
        _showsBlurEffect = YES;
        _firstItemTransform = kDefaultFirstItemTransform;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _showsBlurEffect = YES;
    _firstItemTransform = kDefaultFirstItemTransform;
}

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [(id <UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath].height;
        
    } else {
        return self.itemSize.height;
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *oldItems = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allItems = [[NSMutableArray alloc]initWithArray:oldItems copyItems:YES];
    
    __block UICollectionViewLayoutAttributes *headerAttributes = nil;
    
    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            headerAttributes = attributes;
        }
        else {
            [self updateCellAttributes:attributes withSectionHeader:headerAttributes];
            
        }
    }];
    
    return allItems;
}

- (void)updateCellAttributes:(UICollectionViewLayoutAttributes *)attributes withSectionHeader:(UICollectionViewLayoutAttributes *)headerAttributes {
    // attributes.frame.origin.y 相当于 cell 的 y 在 collectionView 中的位置
    // CGRectGetMinY(self.collectionView.bounds) 相当于 collectionView 的 contentOffset.y
    
    CGFloat minY = (CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top + attributes.frame.origin.y) / 2;
    CGFloat maxY = attributes.frame.origin.y - CGRectGetHeight(headerAttributes.bounds);
    
    NSLog(@"loglogloglog %li", attributes.indexPath.item);
    
    CGFloat finalY = MAX(minY, maxY);
    
    CGPoint origin = attributes.frame.origin;
    
    CGFloat deltaY = (finalY - origin.y) / CGRectGetHeight(attributes.frame);
    
    // 变模糊
    if (self.showsBlurEffect) {
        if ([self.delegate respondsToSelector:@selector(collectionViewFlowLayout:didUpdateCellLayoutAttributes:withProposedFrame:)]) {
            [self.delegate collectionViewFlowLayout:self didUpdateCellLayoutAttributes:attributes withProposedFrame:attributes.frame];
        }
    }
    
    // 缩小
    if (self.firstItemTransform) {
        attributes.transform = CGAffineTransformMakeScale((1- deltaY * self.firstItemTransform), (1 - deltaY * self.firstItemTransform));
    }
    
    
    origin.y = finalY;
    attributes.frame = (CGRect){origin, attributes.frame.size};
    attributes.center = CGPointMake(self.collectionView.center.x, attributes.center.y);
    attributes.zIndex = attributes.indexPath.row;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
    NSLog(@"loglog");
    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset];
}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    
//    // 1.计算scrollview最后停留的范围
//    CGRect proposedRect ;
//    proposedRect.origin = proposedContentOffset;
//    proposedRect.size = self.collectionView.frame.size;
//    
//    // 2.取出这个范围内的所有属性
//    NSArray <UICollectionViewLayoutAttributes *> *array = [self layoutAttributesForElementsInRect:proposedRect];
//    
//    // 起始的x值，也即默认情况下要停下来的x值
//    CGFloat proposedY = proposedContentOffset.y;
//    
//    //3.遍历所有的属性
//    CGFloat adjustOffsetY = 0;
//    if (array.count >= 2) {
//        UICollectionViewLayoutAttributes *attrs = array[1]; // 取出第 1 个 cell 的 Attributes
//        
//        CGFloat attrsY = attrs.frame.origin.y;     // y
//        CGFloat attrsH = attrs.frame.size.height;   // 高
//        
//        if ((attrsY - proposedY) > 30 && (attrsY - proposedY) < (array.firstObject.frame.size.height - 30)) {   // 上拉
//            return CGPointMake(proposedContentOffset.x, attrsY);
//        } else {                                                                                                // 下拉
//            NSLog(@"index : %li, minY : %g,  maxY : %g", attrs.indexPath.item, attrsY, proposedY);
//            return CGPointMake(proposedContentOffset.x, array.firstObject.frame.origin.y);
//        }
//
//    }
//    
//    return CGPointMake(proposedContentOffset.x, proposedContentOffset.y);
//}
//#endif
@end
