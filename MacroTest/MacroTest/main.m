//
//  main.m
//  MacroTest
//
//  Created by ShannonChen on 2017/11/14.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//
// 参考：http://blog.csdn.net/jiaozhentang/article/details/9493653

#import <Foundation/Foundation.h>

#define PRODUCTION   1

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
// 当没有定义 PRODUCTION 或者 PRODUCTION 为 0 时，才执行
#if !defined(PRODUCTION) || !PRODUCTION
        NSLog(@"Hello, World!");
#endif
    }
    return 0;
}
