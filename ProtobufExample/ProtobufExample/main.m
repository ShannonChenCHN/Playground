//
//  main.m
//  ProtobufExample
//
//  Created by ShannonChen on 2018/6/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.pbobjc.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person *p = [[Person alloc] init];
        p.id_p = 1;
        p.name = @"person1";
        p.email = @"123@qq.com";
        
        //encode
        NSData *data = [p data];
        NSLog(@"Protocol Buffers:\n%@\nData: %@\nData Length: %lu", p, data, data.length);
        
        //decode
        Person *newP = [[Person alloc] initWithData:data error:nil];
        NSLog(@"Decoded: %@", newP);
        
    }
    return 0;
}
