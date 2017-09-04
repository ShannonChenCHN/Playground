//
//  SCTableViewDataSource.h
//  Example
//
//  Created by yhouse on 2017/9/4.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SCTableViewCellModel : NSObject

@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) NSString *title;

@end


@interface SCTableViewSectionModel : NSObject

@property (copy, nonatomic) NSString *headerTitle;

@property (strong, nonatomic) NSArray <SCTableViewCellModel *> *cellModels;

@property (copy, nonatomic) NSString *footerTitle;

@end


/**
 table view 的数据源
 */
@interface SCTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray <SCTableViewSectionModel *> *sectionModels;

@end
