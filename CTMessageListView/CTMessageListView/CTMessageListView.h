//
//  CTMessageListView.h
//  CTMessageListView
//
//  Created by ShannonChen on 2018/6/27.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CTMessageListView : UIView

@property (nonatomic, strong) NSArray <NSString *> *models;

- (void)reloadData;

@end
