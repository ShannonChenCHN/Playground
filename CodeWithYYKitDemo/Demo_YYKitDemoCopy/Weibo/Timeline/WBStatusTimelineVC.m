//
//  WBStatusTimelineVC.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/2.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "WBStatusTimelineVC.h"
#import <YYKit.h>
#import "MTTableView.h"
#import "WBStatusLayout.h"
#import "WBStatusCell.h"
#import "WBModel.h"

@interface WBStatusTimelineVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) MTTableView *tableView;
@property (strong, nonatomic) NSMutableArray <WBStatusLayout *>*layouts;

@end

@implementation WBStatusTimelineVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableView = [[MTTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _layouts = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
#warning 16进制颜色
    self.view.backgroundColor = kWBCellBackgroundColor;
    
#warning ???
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _tableView.frame = self.view.bounds;
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];  // tableView的backgroundView!!
    [self.view addSubview:_tableView];
    
    
    // 添加网络加载loading图案
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.size = CGSizeMake(80, 80);
    indicator.center = CGPointMake(self.view.width / 2, self.view.height / 2);
    indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
    indicator.layer.cornerRadius = 6;
    indicator.clipsToBounds = YES;
    [indicator startAnimating];
    [self.view addSubview:indicator];
    
    
#warning GCD多线程
    // 异步加载微博数据
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self p_loadWeiboData];
            
        // 数据加载完毕回到主队列
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = [NSString stringWithFormat:@"Weibo (loaded:%li)", (long)_layouts.count];
            [indicator removeFromSuperview];
            [_tableView reloadData];
        });
    });
}

- (void)p_loadWeiboData {
    for (NSInteger i = 0; i <= 7; i++) {
        NSData *data = [NSData dataNamed:[NSString stringWithFormat:@"weibo_%ld.json", i]];  // 读取json数据
        WBTimelineItem *item = [WBTimelineItem modelWithJSON:data]; // json数据转模型
        for (WBStatus *status in item.statuses) {
            WBStatusLayout *layout = [[WBStatusLayout alloc] initWithStatus:status style:WBLayoutStyleTimeline]; // 计算布局
            [_layouts addObject:layout];
        }
    }
    // 复制一下，让列表长一些，不至于滑两下就到底了
    [_layouts addObjectsFromArray:_layouts];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"WBCell";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[WBStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setStatusLayout:_layouts[indexPath.row]];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _layouts[indexPath.row].cellHeight;
}

@end
