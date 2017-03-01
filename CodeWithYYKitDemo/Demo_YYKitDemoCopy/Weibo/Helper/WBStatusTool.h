//
//  WBStatusTool.h
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/4/19.
//  Copyright © 2016年 Meitun. All rights reserved.
//  工具类

#import <YYKit/YYKit.h>
#import "WBModel.h"


@interface WBStatusTool : NSObject

/// 从微博 bundle 里获取图片 (有缓存)
+ (UIImage *)imageNamed:(NSString *)name;

/// 将微博API提供的图片URL转换成可用的实际URL
+ (NSURL *)defaultURLForImageURL:(id)imageURL;

/// 将 date 格式化成微博的友好显示，返回非空字符串
+ (NSString *)stringWithTimelineDate:(NSDate *)date;

@end
