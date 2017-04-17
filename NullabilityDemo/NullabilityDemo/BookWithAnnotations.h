//
//  BookWithAnnotations.h
//  NullabilityDemo
//
//  Created by ShannonChen on 17/4/17.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookWithAnnotations : NSObject

@property (copy, nonatomic, readonly) NSString *name;

- (nullable instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
