//
//  YIDComingFromTopFlowLayout.h
//  YIDSlideCollectionView
//
//  Created by ShannonChen on 16/8/15.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YIDComingFromTopFlowLayout;

@protocol YIDComingFromTopFlowLayoutDelegate <NSObject>

- (void)collectionViewFlowLayout:(YIDComingFromTopFlowLayout *)flowLayout didUpdateCellLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes withProposedFrame:(CGRect)frame;

@end

@interface YIDComingFromTopFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id <YIDComingFromTopFlowLayoutDelegate> delegate;

@property (assign, nonatomic) CGFloat firstItemTransform;
@property (assign, nonatomic) BOOL showsBlurEffect;

@end
