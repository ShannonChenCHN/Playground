//
//  YIDCollectionViewCell.h
//  YIDSlideCollectionView
//
//  Created by ShannonChen on 16/8/15.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YIDCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (copy, nonatomic) NSString *imageURL;
@property (copy, nonatomic) NSString *nikeName;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (weak, nonatomic) IBOutlet UIView *cover;

@end
