//
//  WBStatusTool.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/4/19.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "WBStatusTool.h"

@implementation WBStatusTool

+ (NSBundle *)bundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ResourceWeibo" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:path];
    });
    return bundle;
}

+ (YYMemoryCache *)imageCache {
    static YYMemoryCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [YYMemoryCache new];
        cache.shouldRemoveAllObjectsOnMemoryWarning = NO;
        cache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
        cache.name = @"WeiboImageCache";
    });
    return cache;
}

+ (UIImage *)imageNamed:(NSString *)name {
    if (!name) return nil;
    UIImage *image = [[self imageCache] objectForKey:name]; // 读取缓存
    if (image) return image;
    NSString *ext = name.pathExtension; // 扩展名
    if (ext.length == 0) ext = @"png";
    NSString *path = [[self bundle] pathForScaledResource:name ofType:ext]; 
    if (!path) return nil;
    image = [UIImage imageWithContentsOfFile:path];         // 读取bundle文件
    image = [image imageByDecoded];
    if (!image) return nil;
    [[self imageCache] setObject:image forKey:name];        // 缓存图片
    return image;
}

+ (NSURL *)defaultURLForImageURL:(id)imageURL {
    /*
     微博 API 提供的图片 URL 有时并不能直接用，需要做一些字符串替换：
     http://u1.sinaimg.cn/upload/2014/11/04/common_icon_membership_level6.png //input
     http://u1.sinaimg.cn/upload/2014/11/04/common_icon_membership_level6_default.png //output
     
     http://img.t.sinajs.cn/t6/skin/public/feed_cover/star_003_y.png?version=2015080302 //input
     http://img.t.sinajs.cn/t6/skin/public/feed_cover/star_003_os7.png?version=2015080302 //output
     */
    
    if (!imageURL) return nil;
    NSString *link = nil;
#warning 对于传进来的URL参数，最好采用id类型，然后在方法内部处理
    if ([imageURL isKindOfClass:[NSURL class]]) {
        link = ((NSURL *)imageURL).absoluteString;
    } else if ([imageURL isKindOfClass:[NSString class]]) {
        link = imageURL;
    }
    if (link.length == 0) return nil;
    
#warning 关于NSString的一些处理方式
    if ([link hasSuffix:@".png"]) {
        // add "_default"
        if (![link hasSuffix:@"_default.png"]) {
            NSString *sub = [link substringToIndex:link.length - 4];
            link = [sub stringByAppendingFormat:@"_default.png"];
        }
    } else {
        // replace "_y.png" with "_os7.png"
        NSRange range = [link rangeOfString:@"_y.png?version"];
        if (range.location != NSNotFound) {
            NSMutableString *mutable = link.mutableCopy;
            [mutable replaceCharactersInRange:NSMakeRange(range.location + 1, 1) withString:@"os7"];
            link = mutable;
        }
    }
    
    return [NSURL URLWithString:link];
}

+ (NSString *)stringWithTimelineDate:(NSDate *)date {
    if (!date) return @"";
#warning 如果频繁使用NSDateFormatter对象，可以将其设为static静态变量，只需创建一次
    static NSDateFormatter *formatterYesterday;
    static NSDateFormatter *formatterSameYear;
    static NSDateFormatter *formatterFullDate;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatterYesterday = [[NSDateFormatter alloc] init];   // 一天以内
        [formatterYesterday setDateFormat:@"昨天 HH:mm"];
        [formatterYesterday setLocale:[NSLocale currentLocale]];
        
        formatterSameYear = [[NSDateFormatter alloc] init];     // 一年以内
        [formatterSameYear setDateFormat:@"M-d"];
        [formatterSameYear setLocale:[NSLocale currentLocale]];
        
        formatterFullDate = [[NSDateFormatter alloc] init];     // 大于一年
        [formatterFullDate setDateFormat:@"yy-M-dd"];
        [formatterFullDate setLocale:[NSLocale currentLocale]];
    });
    
    NSDate *now = [NSDate new];
    NSTimeInterval delta = now.timeIntervalSince1970 - date.timeIntervalSince1970; // 计算时间差
    if (delta < -60 * 10) { // 本地时间有问题
        return [formatterFullDate stringFromDate:date];
    } else if (delta < 60 * 10) { // 10分钟内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 1小时内
        return [NSString stringWithFormat:@"%d分钟前", (int)(delta / 60.0)];
    } else if (date.isToday) { 
        return [NSString stringWithFormat:@"%d小时前", (int)(delta / 60.0 / 60.0)];
    } else if (date.isYesterday) {
        return [formatterYesterday stringFromDate:date];
    } else if (date.year == now.year) {
        return [formatterSameYear stringFromDate:date];
    } else {
        return [formatterFullDate stringFromDate:date];
    }

}


@end
