//
//  SCUserProfileViewController.m
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/10.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCUserProfileViewController.h"

@interface SCUserProfileViewController ()
    


@end

@implementation SCUserProfileViewController
    
    
- (instancetype)initWithUserId:(NSUInteger)userId {
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.userId == kCurrentUserId) {
        self.title = @"我";
    } else {
        self.title = [NSString stringWithFormat:@"%li", self.userId];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
