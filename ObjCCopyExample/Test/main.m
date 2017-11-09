//
//  main.m
//  Test
//
//  Created by ShannonChen on 2017/10/24.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCPerson.h"

void testCopyAndMutableCopy();
void testStringCopy();
void testArrayCopy();
void testPropertyCopy();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        
//        testCopyAndMutableCopy();
//        testStringCopy();
//        testArrayCopy();
//        testPropertyCopy();
        
        SCPerson *person_1 = [[SCPerson alloc] init];
        person_1.age = 16;
        person_1.name = @"Moa";
        
        SCPerson *person_2= person_1.mutableCopy;
        person_2.age = 30;
//        [person_2.name appendString:@"Erica"]; // 会导致 crash
        
        
    }
    
    return 0;
}



// 不论原对象是可变的还是不可变的，copy 之后返回的总是不可变对象，mutableCopy 返回的总是可变对象
void testCopyAndMutableCopy() {
    
    // 1. 非集合对象
    
    // 1.1 不可变对象
    NSString *string = @"origin";                                   // 不可变对象
    NSMutableString *stringCopy = [string copy];                    // 不可变对象
    NSMutableString *stringMutableCopy = [string mutableCopy];      // 可变对象
    

//    [stringCopy appendString:@" haha!"];            // 会导致 crash
    [stringMutableCopy appendString:@" haha!"];
    
    // 1.2 可变对象
    NSMutableString *mutableString = [NSMutableString stringWithString:@"origin"];      // 可变对象
    NSMutableString *mutableStringCopy = [mutableString copy];                          // 不可变对象
    NSMutableString *mutableStringMutableCopy = [mutableString mutableCopy];            // 可变对象
    
//    [mutableStringCopy appendString:@" haha!"];             // 会导致 crash
    [mutableStringMutableCopy appendString:@" haha!"];
    


    // 2. 集合对象
    
    // 2.1 不可变对象
    NSArray *array = @[mutableString, @"b"];                    // 不可变对象
    NSMutableArray *arrayCopy = [array copy];                   // 不可变对象
    NSMutableArray *arrayMutableCopy = [array mutableCopy];     // 可变对象
    
//    [arrayCopy addObject:@"c"];       // 会导致 crash
    [arrayMutableCopy addObject:@"c"];
    
    
    // 2.2 可变对象
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:mutableString, @"b", nil];  // 可变对象
    NSMutableArray *mutableArrayCopy = [mutableArray copy];                                     // 不可变对象
    NSMutableArray *mutableArrayMutableCopy = [mutableArray mutableCopy];                       // 可变对象
    
//    [mutableArrayCopy addObject:@"c"];        // 会导致 crash
    [mutableArrayMutableCopy addObject:@"c"];
}


// 1. 非集合对象
void testStringCopy() {

    
    
    // 1.1 对 immutable 对象进行 copy 操作，是指针复制，进行 mutable copy 操作，是内容复制
    NSString *string = @"origin";
    NSString *stringCopy = [string copy];
    NSString *stringCopy2 = [NSString stringWithString:string];
    NSMutableString *stringMutableCopy = [string mutableCopy];
    NSString *stringStrong = string;
    
    NSLog(@"%p, %p, %p, %p, %p\n", string, stringCopy, stringCopy2, stringMutableCopy, stringStrong);
    
    string = @"Oh, My god!";
    [stringMutableCopy appendString:@" origion?"];
    
    NSLog(@"%p, %p, %p, %p, %p\n", string, stringCopy, stringCopy2, stringMutableCopy, stringStrong);
    NSLog(@"%@, %@, %@, %@, %@\n\n", string, stringCopy, stringCopy2, stringMutableCopy, stringStrong);
    
    
    /*
     变量                                    指针/对象地址            对象值
     
     string                                 0x100002100   --->   @"origin"
     [string copy]                          0x100002100   --->   @"origin"       （拷贝了指针）
     [NSString stringWithString:string]     0x100002100   --->   @"origin"       （拷贝了指针）
     [string mutableCopy]                   0x100503400   --->   @"origin"       （拷贝了对象，指针指向新拷贝过来的对象）
     stringStrong = string;                 0x100002100   --->   @"origin"       （同一指针，指向同一对象）
     
     
     string = @"Oh, My god!";     // 改变指针指向
     [stringMutableCopy appendString:@" origion?"];  // 改变对象内容
     
     string                                 0x1000021a0   --->   @"Oh, My god!"         // 指针发生改变，不再指向原来的对象
     [string copy]                          0x100002100   --->   @"origin"              // 指针不变，还是指向原来的对象，对象内容不变
     [NSString stringWithString:string]     0x100002100   --->   @"origin"              // 指针不变，还是指向原来的对象，对象内容不变
     [string mutableCopy]                   0x100503400   --->   @"origin origion?"     // 指针不变，但是对象内容发生了改变
     stringStrong = string;                 0x100002100   --->   @"origin"              // 指针不变，还是指向原来的对象，对象内容不变
     
     */

    // 1.2 对 mutable 对象进行 copy 和 mutableCopy 都是内容复制，也就是深拷贝
    NSMutableString *mutableString = [NSMutableString stringWithString:@"origin"];
    NSString *mutableStringCopy = [mutableString copy];
    NSMutableString *mutableStringMutableCopy = [mutableString mutableCopy];
    NSMutableString *mutableStringStrong = mutableString;
    
    NSLog(@"%p, %p, %p, %p", mutableString, mutableStringCopy, mutableStringMutableCopy, mutableStringStrong);
    
    [mutableString appendString:@" origion!"]; // 改变 string 的内容，stringCopy 的值不会因此改变
    
    
    NSLog(@"%p, %p, %p, %p", mutableString, mutableStringCopy, mutableStringMutableCopy, mutableStringStrong);
    NSLog(@"%@, %@, %@, %@", mutableString, mutableStringCopy, mutableStringMutableCopy, mutableStringStrong);
    
    /*
    变量                                    指针/对象地址            对象值
    
    
    mutableString                           0x1002065c0        --->   @"origin"
    [mutableString copy]                    0x6e696769726f65   --->   @"origin"             （拷贝了对象本身）
    [mutableString mutableCopy]             0x1002067f0        --->   @"origin"             （拷贝了对象本身）
    mutableStringStrong = mutableString     0x1002065c0        --->   @"origin"             （同一指针，指向同一个对象）
        
        
    [mutableString appendString:@" origion!"]  // 改变对象内容
        
     mutableString                           0x1002065c0       --->   @"origin origion!"    // 指针不变，但对象内容发生改变
     [mutableString copy]                    0x6e696769726f65  --->   @"origin"             // 指针不变，对象内容也不变
     [mutableString mutableCopy]             0x1002067f0       --->   @"origin"             // 指针不变，对象内容也不变
     mutableStringStrong = mutableString     0x1002065c0       --->   @"origin origion!"    // 指针不变，但对象内容也跟着发生了改变，因为指向的的是同一个对象
     
    */
 
}


// 2. 集合对象
void testArrayCopy() {


    
    // 2.1 对 immutable 对象进行 copy 和 mutableCopy 都是内容复制，也就是深拷贝
    NSMutableString *mutableString = @"a".mutableCopy;
    NSArray *array = @[mutableString, @"b"];
    NSArray *arrayCopy = [array copy];
    NSMutableArray *arrayMutableCopy = [array mutableCopy];
    
    NSLog(@"%p, %p, %p", array, arrayCopy, arrayMutableCopy);
    
    [arrayMutableCopy addObject:@"c"];
    
    NSLog(@"%p, %p, %p", array, arrayCopy, arrayMutableCopy);
    NSLog(@"%@, %@, %@", array, arrayCopy, arrayMutableCopy);
    
    [mutableString appendString:@"!"];
    
    NSLog(@"%p, %p, %p", array, arrayCopy, arrayMutableCopy);
    NSLog(@"%@, %@, %@", array, arrayCopy, arrayMutableCopy);
    
    
    /**
    
    array                                   0x1002057d0    --->   [@"a", @"b"]
    [array copy]                            0x1002057d0    --->   [@"a", @"b"]  （拷贝了指针，指向同一个对象）
    [array mutableCopy]                     0x100205ad0    --->   [@"a", @"b"]  （拷贝了第一层对象，指针指向了新拷贝的对象）
    
    
    [arrayMutableCopy addObject:@"c"];  // 添加一个元素
    
     array                                   0x1002057d0    --->   [@"a", @"b"]         // 指针没变，数组对象内容也没变，因为 arrayMutableCopy 是从原数组拷贝过来的，其元素的改变不会影响到原来的数组
     [array copy]                            0x1002057d0    --->   [@"a", @"b"]         // 指针没变，数组对象内容也没变
     [array mutableCopy]                     0x100205ad0    --->   [@"a", @"b", @"c"]   // 指针没变，但是数组中多了一个元素
    
    
    [mutableString appendString:@"!"];  // 修改第一个元素的内容（不是替换元素！）
    
     array                                   0x1002057d0    --->   [@"a!", @"b"]         // 指针没变，第一个元素对象发生了改变
     [array copy]                            0x1002057d0    --->   [@"a!", @"b"]         // 指针没变，第一个元素对象也发生了改变，因为它是指针拷贝
     [array mutableCopy]                     0x100205ad0    --->   [@"a!", @"b", @"c"]   // 指针没变，第一个元素对象也发生了改变，因为它实际上是单层拷贝
    
    */
    
    
    
    // 2.2 对 mutable 对象进行 copy 和 mutableCopy 都是内容复制
    // 2.2.1 单层嵌套
    mutableString = @"a".mutableCopy;
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:mutableString, @"b", nil];  // p1 -> array1
    NSArray *mutableArrayCopy = [mutableArray copy];
    NSMutableArray *mutableArrayMutableCopy = [mutableArray mutableCopy];
    NSArray *mutableArrayDeepCopy = [[NSArray alloc] initWithArray:mutableArray copyItems:YES];
    
    NSLog(@"%p, %p, %p, %p", mutableArray, mutableArrayCopy, mutableArrayMutableCopy, mutableArrayDeepCopy);
    
    [mutableArray addObject:@"c"];
    
    NSLog(@"%p, %p, %p, %p", mutableArray, mutableArrayCopy, mutableArrayMutableCopy, mutableArrayDeepCopy);
    NSLog(@"%@, %@, %@, %@", mutableArray, mutableArrayCopy, mutableArrayMutableCopy, mutableArrayDeepCopy);
    
    
    [mutableString appendString:@"?"];
    
    NSLog(@"%p, %p, %p, %p", mutableArray, mutableArrayCopy, mutableArrayMutableCopy, mutableArrayDeepCopy);
    NSLog(@"%@, %@, %@, %@", mutableArray, mutableArrayCopy, mutableArrayMutableCopy, mutableArrayDeepCopy);
    
    
    /**
     
     mutableArray                                                   0x1002027e0    --->   [@"a", @"b"]
     [mutableArray copy]                                            0x1002028b0    --->   [@"a", @"b"]  （拷贝了第一层对象，但是对象元素仍然是指针复制）
     [mutableArray mutableCopy]                                     0x100202900    --->   [@"a", @"b"]  （拷贝了第一层对象，但是对象元素仍然是指针复制）
     [[NSArray alloc] initWithArray:mutableArray copyItems:YES]     0x100203040    --->   [@"a", @"b"]  （双层拷贝，拷贝了数组对象内容和对象元素的内容）
     
     
     [mutableArray addObject:@"c"];     // 新增了一个元素
     
     mutableArray                                                   0x1002027e0    --->   [@"a", @"b", @"c"]   // 数组内容发生了改变
     [mutableArray copy]                                            0x1002028b0    --->   [@"a", @"b"]   // 数组内容没有发生改变
     [mutableArray mutableCopy]                                     0x100202900    --->   [@"a", @"b"]   // 数组内容没有发生改变
     [[NSArray alloc] initWithArray:mutableArray copyItems:YES]     0x100203040    --->   [@"a", @"b"]   // 数组内容没有发生改变
     
     
     [mutableString appendString:@"?"];  // 修改第一个元素的内容（不是替换元素！）
     
     mutableArray                                                   0x1002027e0    --->   [@"a?", @"b", @"c"]   // 第一个元素对象发生了改变
     [mutableArray copy]                                            0x1002028b0    --->   [@"a?", @"b"]   // 第一个元素对象也发生了改变
     [mutableArray mutableCopy]                                     0x100202900    --->   [@"a?", @"b"]   // 第一个元素对象也发生了改变
     [[NSArray alloc] initWithArray:mutableArray copyItems:YES]     0x100203040    --->   [@"a", @"b"]    // 第一个元素对象没有发生改变，因为这种方法不仅拷贝了数组，而且还拷贝了数组中的每一个元素的内容
     
     */
    
    
    // 2.2.2 双层嵌套
    mutableString = @"a".mutableCopy;
    NSMutableArray *mutableStackedArray = [NSMutableArray arrayWithObjects:@[mutableString, @"b"].mutableCopy, nil];
    NSArray *mutableStackedArrayDeepCopy = [[NSArray alloc] initWithArray:mutableStackedArray copyItems:YES];
    /*
     这里的深拷贝只能拷贝两层，因为 copyWithZone: 这种拷贝方式只能够提供单层深拷贝(one-level-deep copy)，而非真正的深复制。
     如果你用这种方法深复制，集合里的每个对象都会收到 copyWithZone: 消息。
     如果集合里的对象遵循 NSCopying 协议，那么对象就会被深复制到新的集合。
     如果对象没有遵循 NSCopying 协议，而尝试用这种方法进行深复制，会在运行时出错。
    */
    
    
    NSArray *mutableStackedArrayTrueDeepCopy = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:mutableStackedArray]];  // 真正的深拷贝
    
    NSLog(@"%@, %@, %@", mutableStackedArray, mutableStackedArrayDeepCopy, mutableStackedArrayTrueDeepCopy);
    
    [mutableString appendString:@"~"];
    
    NSLog(@"%@, %@, %@", mutableStackedArray, mutableStackedArrayDeepCopy, mutableStackedArrayTrueDeepCopy);
    
    /*
    
     mutableStackedArray                                                        [[@"a", @"b"]]
     [[NSArray alloc] initWithArray:mutableStackedArray copyItems:YES]          [[@"a", @"b"]]       // 双层拷贝/单层深拷贝
     mutableStackedArrayTrueDeepCopy                                            [[@"a", @"b"]]       // 完全深拷贝
     
     [mutableString appendString:@"~"];
    
     mutableStackedArray                                                        [[@"a~", @"b"]]      // 第一集合元素的首元素内容发生了改变
     [[NSArray alloc] initWithArray:mutableStackedArray copyItems:YES]          [[@"a~", @"b"]]      // 第一集合元素的首元素内容也发生了改变
     mutableStackedArrayTrueDeepCopy                                            [[@"a", @"b"]]       // 第一集合元素的首元素内容没有跟着变
     
    */
    
}


void testPropertyCopy() {

    NSMutableString *name = @"Jason".mutableCopy;
    SCPerson *person = [[SCPerson alloc] init];
    person.name = name;  // 使用 copy 关键字的属性，默认会在 setter 方法中将传入的对象进行 copy，所以得到的是一个不可变对象
    
    
    [person printName];
    
    [name appendString:@" Ingle"];
    
    [person printName];
    
//    [person changeName]; // 会在这里崩溃，可以通过重写 setter 方法来解决
    
    [person printName];
}


