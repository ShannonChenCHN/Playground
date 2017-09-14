//
//  SCBlogTableViewController.m
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/11.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCBlogTableViewController.h"

@implementation SCBlogTableViewController

- (instancetype)initWithUserId:(NSString *)userId {
    self = [super init];
    if (self) {
        _userId = userId;
    }
    
    return self;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor yellowColor];
}
    
    
- (void)fetchDataWithCompletionHandler:(void (^)(NSError *, id))completion {
    
}

@end
