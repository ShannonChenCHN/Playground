//
//  Book.h
//  NullabilityDemo
//
//  Created by ShannonChen on 17/4/17.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (copy, nonatomic, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;


@end
