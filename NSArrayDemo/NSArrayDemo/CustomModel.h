//
//  CustomModel.h
//  NSArrayDemo
//
//  Created by ShannonChen on 2017/9/14.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomModel : NSObject <NSCopying>

@property (assign, nonatomic) BOOL flag;
@property (strong, nonatomic) NSString *name;

@end
