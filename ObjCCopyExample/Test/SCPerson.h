//
//  SCPerson.h
//  Test
//
//  Created by ShannonChen on 2017/10/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCPerson : NSObject <NSCopying>

@property (nonatomic, assign) NSInteger age;

@property (copy, nonatomic) NSMutableString *name;

- (void)printName;

- (void)changeName;

@end
