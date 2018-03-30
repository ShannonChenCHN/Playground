//
//  main.m
//  HowToDealWithDecimals
//
//  Created by ShannonChen on 2018/3/30.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        float a = 102100.00 * 2;
        float b = 0.1;
        float num = a + b;
        
        printf("%.2f", num);  // 204200.09
        
//        NSDecimalNumber
        
        printf("\n\n");
    }
    return 0;
}
