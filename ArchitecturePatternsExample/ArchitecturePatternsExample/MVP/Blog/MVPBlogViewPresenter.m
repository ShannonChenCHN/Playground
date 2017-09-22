//
//  MVPBlogViewPresenter.m
//  ArchitecturePatternsExample
//
//  Created by ShannonChen on 2017/9/22.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "MVPBlogViewPresenter.h"

@interface MVPBlogViewPresenter ()

@property (copy, nonatomic) NSString *userId;

@end

@implementation MVPBlogViewPresenter

- (instancetype)initWithUserId:(NSString *)userId {
    if (self = [super init]) {
        
        _userId = userId;
    }
    
    return self;
}

- (void)fetchDataWithCompletionHandler:(void (^)(NSError *, id))completion {
    
}

@end
