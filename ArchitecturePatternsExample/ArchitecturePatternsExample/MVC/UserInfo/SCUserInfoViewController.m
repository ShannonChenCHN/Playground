//
//  SCUserInfoViewController.m
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/11.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCUserInfoViewController.h"
#import "SCUserAPIManger.h"

@implementation SCUserInfoViewController

    
- (instancetype)initWithUserId:(NSString *)userId {
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
    
    SCUserAPIManger *api = [[SCUserAPIManger alloc] initWithUserId:self.userId];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSLog(@"succeed");
        
    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
    }];
    
}

@end
