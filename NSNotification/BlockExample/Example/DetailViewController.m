//
//  DetailViewController.m
//  Example
//
//  Created by ShannonChen on 2018/2/1.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, weak) id <NSObject> observer;

@end

@implementation DetailViewController

- (void)dealloc {
    NSLog(@"%@ is deallocated", NSStringFromClass(self.class));
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    __weak typeof(self) weakSelf = self;
    self.observer = [center addObserverForName:@"TestNotification"
                                        object:nil
                                         queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
                                             // 为什么这个 block 中必须要用 weakSelf ？
                                             // observer 会引用这个 block，这个 block 会 copy self，对 self 强引用，而 observer 要等到被 remove 掉时，才会被移除，所以如果等到在 dealloc 时才 remove observer 的话，就会出现循环引用。
                                             NSLog(@"%@ did receive notification %@", NSStringFromClass(weakSelf.class), note.name);
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [center postNotificationName:@"TestNotification" object:nil];
        
        // 如果在 dealloc 前手动移除 observer，observer 就会被释放掉，observer 通过 block 对 self 的强引用也被释放
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
//        });
    });
    
    
}



@end
