//
//  ImageTableViewCell.h
//  DelaySizedImageInTableView
//
//  Created by ShannonChen on 17/4/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kScreenWidth         [UIScreen mainScreen].bounds.size.width
#define kLeftRightPadding    15
#define kTopBottomPadding    10
#define kImageWidth          (kScreenWidth - 2 * kLeftRightPadding)

@interface ImageTableViewCell : UITableViewCell


@end
