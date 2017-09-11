//
//  SCUserInfoViewController.m
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/11.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCUserInfoViewController.h"

@implementation SCUserInfoViewController

    
- (instancetype)initWithUserId:(NSUInteger)userId {
    self = [super init];
    if (self) {
        _userId = userId;
    }
    
    return self;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor grayColor];
}
    
- (void)fetchDataWithCompletionHandler:(void (^)(NSError *, id))completion {
    
}

@end
