//
//  main.m
//  CharacterEncodeTest
//
//  Created by ShannonChen on 2017/11/17.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *stringArray = [NSMutableArray array];
        
        // 0~9
        for (int i = 48; i <= 57; i++) {
            [stringArray addObject:[NSString stringWithFormat:@"%c", i]];
        }
        
        // A~Z
        for (int i = 65; i <= 90; i++) {
            [stringArray addObject:[NSString stringWithFormat:@"%c", i]];
        }
        
        // a~z
        for (int i = 97; i <= 122; i++) {
            [stringArray addObject:[NSString stringWithFormat:@"%c", i]];
        }
        
        for (NSString *string in stringArray) {
            if (string.length > 0) {
                unichar ASCIIValue = [string characterAtIndex:0];
                NSLog(@"%@, %@", string, @(ASCIIValue));
            }
            
        }
        
    }
    return 0;
}
