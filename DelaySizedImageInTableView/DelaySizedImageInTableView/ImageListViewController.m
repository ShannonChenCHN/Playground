//
//  ImageListViewController.m
//  DelaySizedImageInTableView
//
//  Created by ShannonChen on 17/4/25.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ImageListViewController.h"
#import "ImageTableViewCell.h"
#import "ImageCellModel.h"

#import <SDWebImage/UIImageView+WebCache.h>



@interface ImageListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray <ImageCellModel *> *cellModels;

@end

@implementation ImageListViewController

#pragma mark - Lifecycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    NSArray *imageURLStrings = @[@"http://f.yhres.com/share_article/2017/04/24/EKZmZwHmZQZkAQMinSx_BMe17S2nn.jpg-q75",
                         @"http://f.yhres.com/share_article/2017/04/24/EKZmZwHmZQZkAQMinSx_BMe2rNcJw.jpg-q75",
                         @"http://f.yhres.com/share_article/2017/04/24/EKZmZwHmZQZkAQMinSx_BMe25Krq7.jpg-q75",
                         @"http://f.yhres.com/share_article/2017/04/24/EKZmZwHmZQZkAQMinSx_BMe4Ijy3l.jpg-q75",
                         @"http://f.yhres.com/share_article/2017/04/24/EKZmZwHmZQZkAQMinSx_BMe5rxwl1.jpg-q75",
                         @"http://f.yhres.com/share_article/2017/04/24/EKZmZwHmZQZkAQMinSx_BMe6ekAEk.jpg-q75",
                         @"http://f.yhres.com/share_article/2017/04/24/EKZmZwHmZQZkAQMinSx_BMe90M9lU.jpg-q75",
                         @"http://f.yhres.com/share_article/2017/04/24/EKZmZwHmZQZkAQMinSx_BMfA1F0dV.jpg-q75",
                         @"http://f.yhres.com/share_article/2017/04/24/EKZmZwHmZQZkAQMinSx_BMfDF2wCu.jpg-q75"];
    
    _cellModels = [NSMutableArray array];
    for (NSString *imageURLString in imageURLStrings) {
        
        ImageCellModel *cellModel = [[ImageCellModel alloc] init];
        cellModel.URLString = imageURLString;
        cellModel.displayedImageHeight = kScreenWidth;
        cellModel.needsUpdateImageViewHeight = YES;
        [_cellModels addObject:cellModel];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableView];
}


#pragma mark - <UITableViewDelegate, UITableViewDataSource>
/// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/// row count for each section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModels.count;
}

/// cell configuration
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseIdentifier = @"ImageCell";
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (!cell) {
        cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.backgroundColor = [UIColor lightGrayColor];
    }
    
    if (indexPath.row >= self.cellModels.count) {
        return cell;
    }
    
    ImageCellModel *model = self.cellModels[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.URLString]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 if (!error) {
                                     // 更新高度
                                     CGFloat height = kImageWidth * MIN(image.size.height / image.size.width, 2.0);
                                    
                                     if (model.needsUpdateImageViewHeight) {
                                         model.displayedImageHeight = height;
                                         model.needsUpdateImageViewHeight = NO;
//                                         [tableView reloadData];
                                         [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                     }
                                 }else{
                                     cell.imageView.image = nil;
                                 }
                             }];
    
    return cell;
}

/// cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.cellModels.count) {
        return 0;
    }
    
    NSLog(@"-----%@-----", indexPath);
    return self.cellModels[indexPath.row].cellHeight;
}

/// cell selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] init];
    header.textLabel.text = @"This is a header";
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 180;
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
