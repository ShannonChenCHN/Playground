//
//  MTRootViewController.m
//  Demo_YYKitDemoCopy
//
//  Created by ShannonChen on 16/3/1.
//  Copyright © 2016年 Meitun. All rights reserved.
//

#import "MTRootViewController.h"

@interface MTRootViewController ()

@property (strong, nonatomic) NSMutableArray *titles;
@property (strong, nonatomic) NSMutableArray *classNames;

@end

@implementation MTRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Copy Of YYKit";
    
    self.titles = [NSMutableArray array];  // 设置时最好调用setter方法
    self.classNames = [NSMutableArray array];
    
    [self addCellWithTitle:@"Model" nameOfPushedVC:@"MTModelExample"];
    [self addCellWithTitle:@"Image" nameOfPushedVC:@"MTImageExample"];
    [self addCellWithTitle:@"Text" nameOfPushedVC:@"MTTextExample"];
    [self addCellWithTitle:@"Feed List Demo" nameOfPushedVC:@"MTFeedListExample"];
    
    [self.tableView reloadData]; // 加载数据后，记得刷新表格
}

- (void)addCellWithTitle:(NSString *)title nameOfPushedVC:(NSString *)className {
    [self.titles addObject:title];   // 如果title为空会导致崩溃，这里不处理，因为有助于定位bug，但是如果是加载网络数据，最好做一下保护
    [self.classNames addObject:className];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"YYCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = indexPath.row < _titles.count ? _titles[indexPath.row] : nil;
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *className = indexPath.row < _classNames.count ? _classNames[indexPath.row] : nil;
    Class classOfpushedVC = NSClassFromString(className);
    if (classOfpushedVC) {
        UIViewController *pushedVC = [classOfpushedVC new];
        pushedVC.title = indexPath.row < _titles.count ? _titles[indexPath.row] : nil;
        [self.navigationController pushViewController:pushedVC animated:YES];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
