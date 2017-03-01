//
//  ViewController.m
//  GPUImageDemo
//
//  Created by ShannonChen on 2017/1/20.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "StillImageFilterViewController.h"
#import "LiveVideoFilterViewController.h"
#import "CustomGPUImageViewController.h"


@interface FilterExample : NSObject

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) Class pushedViewController;

+ (FilterExample *)exampleWithTitle:(NSString *)title pushedViewController:(Class)controller;

@end

@implementation FilterExample

+ (FilterExample *)exampleWithTitle:(NSString *)title pushedViewController:(Class)controller {
    FilterExample *example = [[FilterExample alloc] init];
    example.title = title;
    example.pushedViewController = controller;
    
    return example;
}

@end


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray <FilterExample *> *examples;

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.examples = @[
                      [FilterExample exampleWithTitle:@"Still Image Filter" pushedViewController:[StillImageFilterViewController class]],
                      [FilterExample exampleWithTitle:@"live Video Filter" pushedViewController:[LiveVideoFilterViewController class]],
                      [FilterExample exampleWithTitle:@"Custom GPUImage" pushedViewController:[CustomGPUImageViewController class]]
                      ];
}



#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"FilterExampleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row < self.examples.count) {
        FilterExample *example = self.examples[indexPath.row];
        cell.textLabel.text = example.title;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.examples.count) {
        FilterExample *example = self.examples[indexPath.row];
        if ([example.pushedViewController isSubclassOfClass:[UIViewController class]]) {
            UIViewController *pushedViewController = [[example.pushedViewController alloc] init];
            [self.navigationController pushViewController:pushedViewController animated:YES];
        }
    }
}

@end
