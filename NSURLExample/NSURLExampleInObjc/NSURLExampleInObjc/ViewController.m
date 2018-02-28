//
//  ViewController.m
//  NSURLExampleInObjc
//
//  Created by ShannonChen on 2017/5/19.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Absolute URL and relative URL
    NSURL *baseURL = [NSURL URLWithString:@"file:///user/Documents"];
    //    NSURL *baseURL = [NSURL URLWithString:@"file:///user/Documents/"];  // 最后的斜杠“/”会影响后面使用 -URLWithString:relativeToURL: 方法拼接时的结果
    NSURL *anURL = [NSURL URLWithString:@"./Library/Cache" relativeToURL:baseURL];
    
    NSLog(@"%@", anURL.absoluteString);  // file:///user/Library/Cache
    NSLog(@"%s", anURL.fileSystemRepresentation); // /user/Library/Cache
    NSLog(@"%@", anURL.standardizedURL.absoluteString);
    NSLog(@"%@", anURL.filePathURL);
    NSLog(@"%@", anURL.fileReferenceURL);
    NSString *str =nil;
    [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *components = @[@"user", @"doc", @"music"];
    NSURL *fileURL = [NSURL fileURLWithPathComponents:components];
}




@end
