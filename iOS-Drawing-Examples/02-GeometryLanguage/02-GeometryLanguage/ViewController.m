//
//  ViewController.m
//  02-GeometryLanguage
//
//  Created by ShannonChen on 2016/10/12.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "ViewController.h"

#import "GeometryViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Geometry Language";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = @[@"01-Creating A Series of Rectangle Divisions",
                        @"02-Centering A String",
                        @"03-Drawing Image In Center Mode",
                        @"04-Drawing Image In Aspect Fit Mode",
                        @"05-Drawing Image In Aspect Fill Mode",
                        @"06-Drawing Image In Scale To Fill Mode"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GeometryViewController *viewController = [[GeometryViewController alloc] initWithIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
