//
//  MTFeedListExample.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/2.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "MTFeedListExample.h"
#import "YYKit.h"

static CGFloat const kRowHeight = 48.0;

@interface MTFeedListExample ()

@property (strong, nonatomic) NSMutableArray *titles;
@property (strong, nonatomic) NSMutableArray *classNames;
@property (strong, nonatomic) NSMutableArray *icons;

@end

@implementation MTFeedListExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = [NSMutableArray array];
    self.classNames = [NSMutableArray array];
    self.icons = [NSMutableArray array];

    [self addCellWithTitle:@"Twitter" nameOfPushedVC:@"T1HomeTimelineItemsVC" iconName:@"Twitter.jpg"];
    [self addCellWithTitle:@"Weibo" nameOfPushedVC:@"WBStatusTimelineVC" iconName:@"Weibo.jpg"];
    [self.tableView reloadData];
}

- (void)addCellWithTitle:(NSString *)title nameOfPushedVC:(NSString *)className iconName:(NSString *)iconName {
    [self.titles addObject:title];
    [self.classNames addObject:className];
#warning ???
    [self.icons addObject:[YYImage imageNamed:iconName]]; // 从bundle中读取的图片，但不做缓存(+ imageNamed:方法和+ imageWithContentsOfFile:方法)!!!
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"FeedListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = indexPath.row < _titles.count ? _titles[indexPath.row] : nil;
    cell.imageView.image = indexPath.row < _icons.count ? _icons[indexPath.row] : nil;
    
    cell.imageView.layer.cornerRadius = kRowHeight / 2;
    cell.imageView.clipsToBounds = YES;
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = indexPath.row < _classNames.count ? _classNames[indexPath.row] : nil;
    Class pushedClass = NSClassFromString(className);
    if (pushedClass) {
        UIViewController *vc = [pushedClass new];
        vc.title = indexPath.row < _titles.count ? _titles[indexPath.row] :nil;
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
