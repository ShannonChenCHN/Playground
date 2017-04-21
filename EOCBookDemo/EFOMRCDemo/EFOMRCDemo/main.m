//
//  main.m
//  EFOMRCDemo
//
//  Created by ShannonChen on 2017/4/8.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSObject *obj = [[NSObject alloc] init]; // 创建并持有对象 A
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:obj];  // 数组 array 也持有对象 A
//        [array release];
        
        
        [obj release]; // 发送 release 消息，obj 指针不再持有对象 A
        obj = nil;  // 将不再需要的 obj 指针置为 nil，防止出现访问垂悬指针导致异常的问题
        
        NSLog(@"==== %@, %@", obj, array);
        
        [array release];
        
        
        
        Book *aBook = [[Book alloc] init];
        NSString *string = @"Effective Objective-C 2.0";
        aBook.name = string;
        [string release];
        string = nil;
        [aBook resetName];
        NSLog(@"book name: %@", aBook.name);
        
    }
    return 0;
}
