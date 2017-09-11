//
//  SCUserInfoViewController.h
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/11.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 用户信息模块的 controller
 */
@interface SCUserInfoViewController : UIViewController
    
@property (assign, nonatomic) NSUInteger userId;

- (instancetype)initWithUserId:(NSUInteger)userId;
    
- (void)fetchDataWithCompletionHandler:(void(^)(NSError *error, id result))completion;
    
@end
