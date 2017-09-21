//
//  SCBlogTableViewCell.h
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/21.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCEventHandler.h"

@class SCBlogCellModel;


/**
 博客列表 cell
 */
@interface SCBlogTableViewCell : UITableViewCell <SCEventHandler>

@property (strong, nonatomic) SCBlogCellModel *cellModel;

@end
