//
//  SCUserProfileViewController.h
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/10.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kCurrentUserId = @"123";


/**
 个人详情
 */
@interface SCUserProfileViewController : UIViewController

@property (copy, nonatomic) NSString *userId;
    
- (instancetype)initWithUserId:(NSString *)userId;

    
@end
