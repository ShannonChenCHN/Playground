//
//  ImageCellModel.h
//  DelaySizedImageInTableView
//
//  Created by ShannonChen on 17/4/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCellModel : NSObject

@property (copy, nonatomic) NSString *URLString;
@property (assign, nonatomic) BOOL needsUpdateImageViewHeight;
@property (assign, nonatomic) CGFloat displayedImageHeight;

- (CGFloat)cellHeight;

@end
