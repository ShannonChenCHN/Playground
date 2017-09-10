//
//  ViewController.m
//  01-EllipseImageDrawing
//
//  Created by ShannonChen on 16/10/5.
//  Copyright © 2016年 YHouse. All rights reserved.
//

#import "ViewController.h"
#import "GraphicViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tabeView;
@property (strong, nonatomic) NSArray *cellTitles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabeView.tableFooterView = [[UIView alloc] init];
    self.cellTitles = @[@"drawImageWithinAQuartzContext", @"drawImageWithinAnUIKitContext", @"drawImageWithBezierPath", @"Draw Alpabet Text Circle ",  @"Transforming Contexts During Drawing", @"Precise Text Placement Around a Circle", @"Conflicting Line Widths", @"Dashes"];
    
}



#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%02li-%@", indexPath.row + 1, self.cellTitles[indexPath.row]];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GraphicViewController *viewController = [[GraphicViewController alloc] initWithIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
