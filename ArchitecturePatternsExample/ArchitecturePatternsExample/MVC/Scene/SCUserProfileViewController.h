//
//  SCUserProfileViewController.h
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/10.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSUInteger kCurrentUserId = 123;


@interface SCUserProfileViewController : UIViewController

@property (assign, nonatomic) NSUInteger userId;
    
- (instancetype)initWithUserId:(NSUInteger)userId;
    
@end
