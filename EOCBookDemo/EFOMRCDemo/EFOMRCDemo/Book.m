//
//  Book.m
//  EFOMRCDemo
//
//  Created by ShannonChen on 2017/4/8.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "Book.h"

@implementation Book

- (void)setName:(NSString *)name {
    NSLog(@"%p, %p", _name, name);
    [_name release];
    [name retain];
    _name = name;
}

- (void)resetName {
    
    self.name = _name;
}

@end

