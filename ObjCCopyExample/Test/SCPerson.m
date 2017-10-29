//
//  SCPerson.m
//  Test
//
//  Created by ShannonChen on 2017/10/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCPerson.h"

@implementation SCPerson

//- (void)setName:(NSMutableString *)name {
//    _name = [name mutableCopy];
//    
//    // 使用 copy 关键字的属性，默认会在 setter 方法中将传入的对象进行 copy，所以会得到的是一个不可变对象
//    // 在这里重写了 setter 方法，采用 mutableCopy 操作，所以最后得到的是一个可变对象
//    
//}

- (void)printName {
    NSLog(@"%@", self.name);
}

- (void)changeName {
    [self.name appendString:@" Kidd"];
}

@end
