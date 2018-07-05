//
//  main.m
//  HowToDealWithDecimals
//
//  Created by ShannonChen on 2018/3/30.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

void printBinary(float num) {
    unsigned long buff;
    char s[35];
    
    // 将数据复制到 4 字节长度的整数变量 buff 中以逐个提出出每一位
    memcpy(&buff, &num, 4);
    
    // 逐一取出每一位
    for (int i = 33; i >= 0; i--) {
        if (i == 1 || i == 10) {
            s[i] = '-';
        } else {
            if (buff % 2 == 1) {
                s[i] = '1';
            } else {
                s[i] = '0';
            }
            buff /= 2;
        }
    }
    
    s[34] = '\0';
    
    printf("%s\n", s);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        float a = 102100.00 * 2;
        float b = 0.1;
        float num = a + b;
        
        printf("%p, %p, %p", &a, &b, &num);
        
        printf("\n\n");
        
        printf("%.2f", num);  // 这里应该是 204200.10，但是打印的却是 204200.09
        
        printf("\n\n");
//        NSDecimalNumber
        
        printBinary(0.1);
        
        printf("\n\n");
    }
    return 0;
}
