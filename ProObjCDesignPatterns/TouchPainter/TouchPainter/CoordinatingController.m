//
//  CoordinatingController.m
//  TouchPainter
//
//  Created by ShannonChen on 2017/10/30.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "CoordinatingController.h"

@implementation CoordinatingController


+ (instancetype)sharedInstance {
    static CoordinatingController *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[super allocWithZone:NULL] init];
        }
    });
    
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}




@end
